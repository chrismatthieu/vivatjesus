class PagesController < ApplicationController

  before_filter :current_user  
  before_filter :current_council  
  
  def index
    
    if @council #and @council.id > 1
      @post = Post.first :conditions => ["privateflag = ? and council_id = ?", false, @council.id], :order => 'created_at DESC'
      render "index"
    else
      @councils = Council.all
      render "social"
    end  
    
  end
  
  def about
    @users = User.order("username").where("officer = true and council_id = ?", @council.id)
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
    redirect_to @council.mobileurl    
  end

end
