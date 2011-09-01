class PagesController < ApplicationController

  before_filter :current_user  
  
  def index
    @post = Post.first :conditions => ["privateflag = ?", false], :order => 'created_at DESC'
    
    render :layout => false 
  end
  
  def about
    @users = User.order("username").where("officer = true")
  end
  
  def contact
    if params[:newsletteremail]
      
      if params[:newsletteremail].index("@")
        @answer = true
        @message = "Please add me to your email newsletter!"
        Notifier.contact("chris@matthieu.us", params[:newsletteremail],  @message).deliver
      end
      
    elsif params[:contact][:answer] == params[:contact][:mathanswer] and params[:contact][:mathanswer].to_i > 0
      @answer = true
      @message = params[:contact][:message] + ' - ' + params[:contact][:fullname]
      Notifier.contact("chris@matthieu.us", params[:contact][:emailaddress],  @message).deliver
      
    else
      @answer = false
    end

  end
  
  def mobile
    redirect_to "http://www.radioindy.com/kofc/index.html"
  end

end
