class PagesController < ApplicationController

  before_filter :current_user  
  before_filter :current_council  
  
  def index
    
    if @council
      @post = Post.first :conditions => ["privateflag = ? and council_id = ?", false, @council.id], :order => 'created_at DESC'
      render "index"      
    elsif @current_user 
      @council = Council.find(@current_user.council_id)
      @post = Post.first :conditions => ["privateflag = ? and council_id = ?", false, @current_user.council_id], :order => 'created_at DESC'
      render "index"
    else
      @councils = Council.find(:all, :conditions => ["councilname <> ''"], :order => 'councilnumber')
      render "social"
    end  
    
  end
  
  def about
    if @current_user
      @users = User.order("username").where("officer = true and council_id = ?", @current_user.council_id)
    elsif @council 
      @users = User.order("username").where("officer = true and council_id = ?", @council.id)
    end
    
  end

  def news
    if !@council
      @council = Council.find(:first, :conditions => ["id = ?", @current_user.council_id])
    end
  end
  
  def contact

    if @council and !@council.email.blank?
      @tomail = @council.email
    else
      @tomail = "chris@matthieu.us"
    end

    if params[:newsletteremail]
      
      if params[:newsletteremail].index("@")
        @answer = true
        @message = "Please add me to your email newsletter!"
        Notifier.contact(@tomail, params[:newsletteremail],  @message).deliver
      end
      
    elsif params[:contact][:answer] == params[:contact][:mathanswer] and params[:contact][:mathanswer].to_i > 0
      @answer = true
      @message = params[:contact][:message] + ' - ' + params[:contact][:fullname]
      Notifier.contact(@tomail, params[:contact][:emailaddress],  @message).deliver
      
    else
      @answer = false
    end

  end
  
  def mobile
    # redirect_to @council.mobileurl    
  end
  
end
