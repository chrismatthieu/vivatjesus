class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    @subdomain = request.subdomain
  end
  helper_method :current_user

  def current_council
    @subdomain = request.subdomain
    if @subdomain.nil? or @subdomain == "www" or @subdomain == "" 
      @council = Council.find(1)
    else
      @council = Council.find_by_councilnumber(@subdmail)
      if @council.nil?
        @council = Council.find(1)      
      end
    end
  end
  
  def admin_required
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    if @current_user 
      if !@current_user.admin
        redirect_to '/'
      end
    else
       redirect_to '/'
    end
  end

  def login_required
    @current_user ||= User.find(session[:user_id]) if session[:user_id]

    if !@current_user 
       redirect_to '/'
    end
  end
  
end
