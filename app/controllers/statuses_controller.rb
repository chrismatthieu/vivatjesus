class StatusesController < ApplicationController
  
  require 'rubygems'
  require 'open-uri'
  require 'cgi'
  require 'rest-client'
  
  
  # before_filter :client, :only => [:create]
  before_filter :current_user  
  before_filter :current_council  
  before_filter :client, :only => [:create]
  # skip_before_filter :verify_authenticity_token, :only => [:destroy]
  
  
  
  # GET /statuses
  # GET /statuses.json
  def index
    
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    @page = @page + 1   
    
    # @statuses = Status.find(:all, :order => "created_at DESC")
    @statuses = Status.paginate :page => params[:page], :order => 'created_at DESC' #, :per_page => 3

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
      format.js
    end
  end

  def pollfeed
    @statuses = Status.paginate :page => params[:page], :order => 'created_at DESC', :conditions=>['created_at > ?', Time.now - 10.seconds]                
    respond_to do |format|  
      format.js { render :action => 'pollfeed.js.coffee', :content_type => 'text/javascript'}
    end 
  end

  # GET /statuses/1
  # GET /statuses/1.json
  def show
    @status = Status.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/new
  # GET /statuses/new.json
  def new
    @status = Status.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @status }
    end
  end

  # GET /statuses/1/edit
  def edit
    @status = Status.find(params[:id])
  end

  # POST /statuses
  # POST /statuses.json
  def create
    
    # API Status Update - Basic Authentication
    if !session["user_id"]
      authenticate_or_request_with_http_basic do |username, password|
        if request.url.index('localhost')
          user = User.find(:first, :conditions => ['username LIKE ?', username.strip])
        else
          user = User.find(:first, :conditions => ['username ILIKE ?', username.strip])
        end

        if user && user.authenticate(password)
          session["user_id"] = user.id
        end
      end
    end
    

    respond_to do |format|
      
      if params[:status] and params[:status][:message] 
        postmessage = params[:status][:message]
      elsif params[:message] 
        postmessage = params[:message]
      end
      
      if session["user_id"] and postmessage

        @status = Status.new 
        @status.user_id = session["user_id"]
        @status.message = postmessage    
        @status.save
        
        @activity = Activity.new
        @activity.user_id = session["user_id"]
        @activity.status_id = @status.id
        @activity.save
        
        # Check if message includes a callsign 
        txtcall = @status.message.gsub("@", "")
        re="((?:[a-z][a-z]*[0-9]+[a-z0-9]*))"	# Alphanum 1
        m=Regexp.new(re,Regexp::IGNORECASE);
        callsign = m.match(txtcall)
        
        # Send mention email
        if callsign
          
          if request.url.index('localhost')
            @mention = User.find(:first, :conditions => ['username LIKE ?', callsign[0]])
          else
            @mention = User.find(:first, :conditions => ['username ILIKE ?', callsign[0]])
          end
          
          if @mention and @mention.email and @mention.allowemail != false
              begin
                MentionMailer.alerter(session[:username], @mention.username, session[:image], @mention.email, @activity.id.to_s).deliver
              rescue
              end
          end
          
        end
        
          
        # Tweet
        if session['access_token'] and params[:status][:twitter] == "1"
          @client.update(@status.message)
        end            
        
        # FB
        if session['fbtoken'] and params[:status][:facebook] == "1"
          RestClient.post 'https://graph.facebook.com/' + session['fbid'] + '/feed', :access_token => session['fbtoken'], :message => @status.message
        end
            
        
        format.html { redirect_to @status, notice: 'Status was successfully created.' }
        # format.json { render json: @status, status: :created, location: @status }
        format.js { render :action => 'create.js.coffee', :content_type => 'text/javascript'}
        format.json { render :json => @status}
      else
        format.html { render action: "new" }
        format.json {   }
      end
    end
  end

  # PUT /statuses/1
  # PUT /statuses/1.json
  def update
    @status = Status.find(params[:id])

    respond_to do |format|
      if @status.update_attributes(params[:status])
        format.html { redirect_to @status, notice: 'Status was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @status.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /statuses/1
  # DELETE /statuses/1.json
  def destroy
    @status = Status.find(params[:id])
    if session["user_id"] == @status.user_id
      @status.destroy
    end

    respond_to do |format|
      format.html { redirect_to statuses_url }
      # format.json { head :ok }
      format.js { render :action => 'destroy.js.coffee', :content_type => 'text/javascript'}
    end
  end  
  
end
