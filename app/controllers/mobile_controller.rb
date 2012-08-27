class MobileController < ApplicationController
  before_filter :current_council  
  before_filter :current_user  
  layout :false

  def index
  	@councils = Council.find(:all, :conditions => ["councilname <> ''"], :order => 'councilnumber')  	
  end

  def menu

  	if params[:council] 
  		session["mobilecouncil"] = params[:council]    
  	end
	  @council = Council.find(session["mobilecouncil"])
    
  end


  def about    
	  @council = Council.find(session["mobilecouncil"])    
  end


  def news    
	   @council = Council.find(session["mobilecouncil"])  
     @posts = Post.find(:all, :conditions => ['council_id = ?', @council.id], :order => 'created_at DESC', :limit=>10)
  
  end


  def post     
     @council = Council.find(session["mobilecouncil"])  
     @post = Post.find(params[:id])
  
  end

  def calendar    
	  @council = Council.find(session["mobilecouncil"])    
  end


  def timeline  

	  @council = Council.find(session["mobilecouncil"])  
    @page = params[:page].to_i
    if @page == 0
      @page = 1
    end
    @page = @page + 1   
    
    # @statuses = Status.find(:all, :order => "created_at DESC")
    @activities = Activity.paginate :page => params[:page], :conditions => ["council_id = ?", session["mobilecouncil"]], :order => 'updated_at DESC' #, :per_page => 3

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @statuses }
      format.js
    end
  
  end

end
