xml.instruct! :xml, :version=>"1.0"
xml.rss(:version=>"2.0") do
  xml.channel do
    xml.title "VivatJesus Activity Feed"
    xml.link "http://VivatJes.us/activity"
    xml.description "VivatJesus : Knights of Columbus social network."
    xml.language 'en-us'
    @activities.each do |activity|
      
      @followuser = activity.user rescue nil

    	if @followuser

    		if activity.status_id 
    			@statusmessage = "Status Update: " + Status.find(activity.status_id).message rescue "Removed status"
    		elsif activity.follow_id 
    			@follow = Follow.find(activity.follow_id) rescue nil 
    			@followed = User.find(@follow.follow_id) rescue nil
    			@statusmessage = "Followed: " +  link_to(@followed.username.upcase, '/' + @followed.username)  rescue "Unfollowed user" 
    		elsif activity.register_id 
    			@statusmessage = "Joined VivatJesus!" 
    		elsif activity.contact_id 
    			@contact = Contact.find(activity.contact_id) rescue nil
    			@statusmessage = "Contacted: " +  @contact.fullname + " (" + link_to(@contact.callsign.upcase, '/' + @contact.callsign) + ")" + " in " + @contact.state + ", " + @contact.country + " on " + @contact.band + " " + @contact.mode + " " + @contact.txpower + " Watts " + " " + @contact.txsignal + " " + @contact.comment  rescue "Removed contact"
    		else 
    			@statusmessage = activity.message 
    		end 
    	
    	
        xml.item do
          xml.title @statusmessage
          xml.description @statusmessage
          xml.author "#{@followuser.username.upcase}"
          xml.pubDate activity.created_at
          xml.link "http://VivatJes.us/activity/" + activity.id.to_s
          xml.guid "http://VivatJes.us/activity/" + activity.id.to_s
        end
    	
    	
    	
    	
    	end
      
      
      
      
    end
  end
end
