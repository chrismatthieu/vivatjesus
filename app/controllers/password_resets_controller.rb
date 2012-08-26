class PasswordResetsController < ApplicationController

  before_filter :current_user  
  before_filter :current_council  

  def new
  end
  
  def create
    if request.url.index('localhost')
      user = User.find(:first, :conditions => ['username LIKE ?', params[:username].strip])
     else
      user = User.find(:first, :conditions => ['username ILIKE ?', params[:username].strip])
    end

    user.send_password_reset if user
    redirect_to root_url, :notice => "Email sent with password reset instructions."
  end
  
  def edit
    @user = User.find_by_password_reset_token!(params[:id])
  end
  
  def update
    @user = User.find_by_password_reset_token!(params[:id])
    if @user.password_reset_sent_at < 2.hours.ago
      redirect_to new_password_reset_path, :alert => "Password &crarr; 
        reset has expired."
    elsif @user.update_attributes(params[:user])
      redirect_to root_url, :notice => "Password has been reset."
    else
      render :edit
    end
  end

end
