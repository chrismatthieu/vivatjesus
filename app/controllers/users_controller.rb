class UsersController < ApplicationController
  
  before_filter :login_required, :except => [:new, :create]
  before_filter :current_council  
  
  # GET /users
  # GET /users.json
  def index
    respond_to do |format|
      format.html {
        # if @current_user.member
          @users = User.order("username").where("council_id = ?", @current_user.council_id)
        # else
          # redirect_to "/pending"
        # end
      }
      # format.json { render :json => @users }
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @user = User.find(params[:id])
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    @page = @page + 1   
    
    if params[:id] and isNumeric(params[:id])
      @user = User.find(params[:id])
    else
      
      # @user = User.find_by_username(@callsign)
      if request.url.index('localhost')
        @user = User.find(:first, :conditions => ['username LIKE ?', params[:user]])
       else
        @user = User.find(:first, :conditions => ['username ILIKE ?', params[:user]])
      end
      
      
    end
    
    if @user
      
      @follow = Follow.find(:first, :conditions => ["user_id = ? and follow_id = ?", session[:user_id], @user.id])
      @block = Follow.find(:first, :conditions => ["user_id = ? and block_id = ?", session[:user_id], @user.id])
      
      @following = Follow.count(:conditions => ["user_id = ?", @user.id])
      @followers = Follow.count(:conditions => ["follow_id = ?", @user.id])

      # # @activities = User.comments.paginate :page => params[:page], :per_page => 3
      # @activities = Comment.paginate :page => params[:page], :conditions => ['user_id = ?', @user.id], :order => 'updated_at DESC'
      @activities = Activity.paginate :page => params[:page], :conditions => ['user_id = ?', @user.id], :order => 'activities.updated_at DESC'     
            
    end #@user

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/new
  # GET /users/new.json
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @user }
    end
  end

  # GET /users/1/edit
  def edit
    
    if @current_user.admin
      if params[:id] and isNumeric(params[:id])
        @user = User.find(params[:id])
      else
        # @user = User.find_by_username(params[:id])
        if request.url.index('localhost')
          @user = User.find(:first, :conditions => ['username LIKE ?', params[:user]])
         else
          @user = User.find(:first, :conditions => ['username ILIKE ?', params[:user]])
        end
      end

    else
      @user = User.find(@current_user.id)
    end
    
  end

  # GET /users/1/edit
  def password
    # if @current_user.admin
    #   @user = User.find(params[:id])
    # else
    #   @user = User.find(@current_user.id)
    # end

    @user = User.find(@current_user.id)

  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(params[:user])
    
    # generate API Key 
    values = [
            rand(0x0010000),
            rand(0x0010000),
            rand(0x0010000),
            rand(0x0010000),
            rand(0x0010000),
            rand(0x1000000),
            rand(0x1000000),
          ]
    token = "%04x%04x%04x%04x%04x%06x%06x" % values
    if token
      @user.token = token
    end
    
    @user.council_id = @council.id

    respond_to do |format|
      if @user.save
        session[:user_id] = @user.id
        format.html { redirect_to @user, :notice => 'User was successfully created.' }
        format.json { render :json => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.json
  def update
    if @current_user.admin
      @user = User.find(params[:id])
    else
      @user = User.find(@current_user.id)
    end
    
    respond_to do |format|
      if @user.update_attributes(params[:user])
        format.html { redirect_to @user, :notice => 'User was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if @current_user.admin
      @user = User.find(params[:id])
    else
      @user = User.find(@current_user.id)
    end
    
    @user.destroy

    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :ok }
    end
  end
  
  def allfeed       
    
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    @page = @page + 1   

     respond_to do |format|
       format.html {
         @activities = Activity.paginate :page => params[:page], :order => 'updated_at DESC' 
       }
       format.rss { 
         @activities = Activity.find(:all, :order => 'created_at DESC', :limit =>30)
         render :layout=>false 
       }
       format.js {
         @activities = Activity.paginate :page => params[:page], :order => 'updated_at DESC' 
       }
     end
  end
  
  def showfeed
    # @activities = Activity.find(params[:id])   
    @activities = Activity.find(:all, :conditions => ["id = ?", params[:id]])              
  end
  
  def pollallfeed
    @activities = Activity.paginate :page => params[:page], :order => 'activities.updated_at DESC', :conditions=>['created_at > ?', Time.now - 10.seconds]                
    respond_to do |format|  
      format.js { render :action => 'pollallfeed.js.coffee', :content_type => 'text/javascript'}
    end

  end

  def feed     
    
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    @page = @page + 1   
    
     
     # @activities = Activity.paginate :page => params[:page], :select => "comments.user_id, comments.verse_id, comments.comment, comments.color, comments.updated_at",  
     # :conditions => ["follows.user_id = ? or comments.user_id = ?", @current_user.id, @current_user.id],
     # :joins => "left outer join follows on comments.user_id = follows.follow_id or comments.user_id = #{@current_user.id}",
     # :order => 'comments.updated_at DESC'

     @activities = Activity.paginate :page => params[:page],  
     :conditions => ["follows.user_id = ? or activities.user_id = ?", session[:user_id], session[:user_id]],
     :joins => "left outer join follows on activities.user_id = follows.follow_id or activities.user_id = #{session[:user_id]}",
     :order => 'activities.updated_at DESC',
     :select => 'DISTINCT(activities.id), activities.*'
     
     respond_to do |format|
       format.html 
       format.rss { render :action => "allfeed", :layout=>false }
       format.js 
       
     end
     
          
  end

  def pollfeed     
     
     @activities = Activity.paginate :page => params[:page],  
     :conditions => ["(follows.user_id = ? or activities.user_id = ?) and (activities.created_at > ?)", session[:user_id], session[:user_id], Time.now - 10.seconds],
     :joins => "left outer join follows on activities.user_id = follows.follow_id or activities.user_id = #{session[:user_id]}",
     :order => 'activities.updated_at DESC',
     :select => 'DISTINCT(activities.id), activities.*'
                    
     respond_to do |format|  
       format.js { render :action => 'pollallfeed.js.coffee', :content_type => 'text/javascript'}
     end
     
          
  end
  
  def deauthtwitter
    @twitter = User.find(session[:user_id])
    @twitter.uid = nil
    @twitter.provider = nil
    @twitter.access_token = nil
    @twitter.access_secret = nil
    @twitter.save
    
    session['uid'] = nil
    session['provider'] = nil
    session['access_token'] = nil 
    session['access_secret'] = nil
    
    redirect_to "/users/#{@twitter.username.downcase}/edit"
    
  end

  def deauthfacebook
    @fb = User.find(session[:user_id])
    @fb.fbid = nil
    @fb.fbtoken = nil
    @fb.save
    
    session['fbid'] = nil 
    session['fbtoken'] = nil 
    
    redirect_to "/users/#{@fb.username.downcase}/edit"
    
  end
  
end
