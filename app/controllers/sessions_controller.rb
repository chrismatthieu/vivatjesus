class SessionsController < ApplicationController
  before_filter :current_council  
  
  def new
  end
  def create
    
    # get the service parameter from the Rails router
    params[:service] ? service_route = params[:service] : service_route = 'No service recognized (invalid callback)'

    # get the full hash from omniauth
    omniauth = request.env['omniauth.auth']
        
    # continue only if hash and parameter exist
    if omniauth and params[:service]

      # map the returned hashes to our variables first - the hashes differs for every service
      
      # create a new hash
      @authhash = Hash.new
      
      if service_route == 'facebook'
        # Dont forget to set facebook config URL to http://VivatJes.us
        
        omniauth['extra']['raw_info']['email'] ? @authhash[:email] =  omniauth['extra']['raw_info']['email'] : @authhash[:email] = ''
        omniauth['extra']['raw_info']['username'] ? @authhash[:name] =  omniauth['extra']['raw_info']['username'] : @authhash[:name] = ''
        omniauth['extra']['raw_info']['id'] ?  @authhash[:uid] =  omniauth['extra']['raw_info']['id'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''
       
        omniauth['info']['image'] ? @authhash[:photo] =  omniauth['info']['image'] : @authhash[:photo] = ''
        
        omniauth['credentials']['token'] ? @authhash[:token] =  omniauth['credentials']['token'] : @authhash[:token] = ''
        omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
                
      elsif service_route == 'twitter'
        # omniauth['info']['email'] ? @authhash[:email] =  omniauth['user_info']['email'] : @authhash[:email] = ''
        omniauth['info']['nickname'] ? @authhash[:name] =  omniauth['info']['nickname'] : @authhash[:name] = ''
        omniauth['info']['name'] ? @authhash[:name] =  omniauth['info']['name'] : @authhash[:name] = ''
        omniauth['uid'] ? @authhash[:uid] = omniauth['uid'].to_s : @authhash[:uid] = ''
        omniauth['provider'] ? @authhash[:provider] = omniauth['provider'] : @authhash[:provider] = ''        
      
        omniauth['info']['image'] ? @authhash[:photo] = omniauth['info']['image'] : @authhash[:photo] = ''        
        
        omniauth['credentials']['token'] ? @authhash[:token] = omniauth['credentials']['token'] : @authhash[:token] = ''        
        omniauth['credentials']['secret'] ? @authhash[:secret] = omniauth['credentials']['secret'] : @authhash[:secret] = ''        
                        
      else        
        # debug to output the hash that has been returned when adding new services
        render :text => omniauth.to_yaml
        return
      end 

      
      if @authhash[:uid] != '' and @authhash[:provider] != ''
        
        @auth = User.find(session[:user_id])

        if @auth 
          
          if service_route == 'facebook'

            @auth.fbid = @authhash[:uid]            
            @auth.fbtoken = @authhash[:token] 
            @auth.photo = @authhash[:photo]
            @auth.save
            session['fbid'] = @authhash[:uid]  
            session['fbtoken'] = @authhash[:token]  
            redirect_to "/facebook", :notice => "VivatJesus Linked to Facebook"
            
          elsif service_route == 'twitter'
            
            @auth.uid = @authhash[:uid]
            @auth.provider = @authhash[:provider]
            @auth.access_token = @authhash[:token]  
            @auth.access_secret = @authhash[:secret]  
            @auth.photo = @authhash[:photo]
          
            session['uid'] = @authhash[:uid]
            session['provider'] = @authhash[:provider]
            session['access_token'] = @authhash[:token]  
            session['access_secret'] = @authhash[:secret] 
            @auth.save
            redirect_to "/twitter", :notice => "VivatJesus Linked to Twitter"
          
          end
          

        else

          redirect_to "/activity", :notice => "Twitter authentication failed."

        end
        
      else
        flash[:notice] =  'Error while authenticating via ' + service_route + '/' + @authhash[:provider].capitalize + '. The service returned invalid data for the user id.'
        redirect_to root_url
      end
      
    else
    
        # user = User.find_by_username(params[:username])
        if request.url.index('localhost')
          user = User.find(:first, :conditions => ['username LIKE ?', params[:username].strip])
         else
          user = User.find(:first, :conditions => ['username ILIKE ?', params[:username].strip])
        end
    
        if user && user.authenticate(params[:password])
          session[:user_id] = user.id
          session[:username] = user.username
          redirect_to '/activity', :notice => "Logged in"
        else
          flash.now.alert = "Invalid username or password"
          render "new"
        end

    end
  end

  def destroy
    session[:user_id] = nil
    session[:username] = nil
    redirect_to root_url, :notice => "Logged out"
  end
end
