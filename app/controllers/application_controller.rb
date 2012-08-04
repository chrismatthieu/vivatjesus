class ApplicationController < ActionController::Base
  protect_from_forgery

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_council
    @subdomain = request.env['HTTP_HOST'].split(".")[0].downcase
    if @subdomain == "www" or @subdomain == "vivatjes" 
      # @council = Council.find(1)
      @council = nil
    else
      @council = Council.find_by_councilnumber(@subdomain)
      # if @council.nil?
      #   @council = Council.find(1)      
      # end
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
  
  def isNumeric(s)
      Float(s) != nil rescue false
  end
  
  def client
    Twitter.configure do |config|
      config.consumer_key = 'yFbqzAzWUPSJZaLDCQA' #ENV['CONSUMER_KEY']
      config.consumer_secret = 'yZLMxkcnOA2IDCLo3twTU3uVLvL1l4foKznBOB7ADFA' #ENV['CONSUMER_SECRET']
      # 73s' tokens for verse tweets
      config.oauth_token = session['access_token']
      config.oauth_token_secret = session['access_secret']
    end
    @client ||= Twitter::Client.new
  end
  
end
