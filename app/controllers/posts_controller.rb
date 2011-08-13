class PostsController < ApplicationController

  before_filter :current_user  

  # GET /posts
  # GET /posts.json
  def index
    # @posts = Post.order("created_at DESC")
    # @posts = Post.all :page => params[:page], :order => 'created_at DESC'
    @posts = Post.paginate :page => params[:page], :per_page => 3, :order => 'created_at DESC'

    respond_to do |format|
      format.html # index.html.erb
      format.json { render :json => @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render :json => @post }
    end
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(params[:post])
    @post.user_id = @current_user.id

    respond_to do |format|
      if @post.save
        format.html { redirect_to @post, :notice => 'Post was successfully created.' }
        format.json { render :json => @post, :status => :created, :location => @post }
      else
        format.html { render :action => "new" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render :action => "edit" }
        format.json { render :json => @post.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to posts_url }
      format.json { head :ok }
    end
  end
  
  def search
    @keywords = "%" + params[:keywords] + "%"
    if request.url.index('localhost')
      conditions = ["poddesc LIKE ? or podname LIKE ?", @keywords, @keywords] unless @keywords == ""
    else
      conditions = ["poddesc ILIKE ? or podname ILIKE ?", @keywords, @keywords] unless @keywords == ""
    end
    # @posts = Post.find(:all, :conditions => conditions, :order => 'created_at desc')
    @posts = Post.paginate :page => params[:page], :per_page => 3, :order => 'created_at DESC', :conditions => conditions
    
    render :action => 'index'    
  end
  
  # def rss
  #   redirect_to 'http://feeds.feedburner.com/vivatjesus'    
  # end

  def rss    
    @posts = Post.find(:all, :order => "created_at desc")
    render :action => 'rss', :content_type => "application/xml", :layout => false 
    
  end
  
  
  
end
