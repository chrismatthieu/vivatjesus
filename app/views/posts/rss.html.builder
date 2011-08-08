xml.instruct! :xml, :version=>"1.0" 
xml.rss ("version"=>"2.0", "xmlns:itunes"=>"http://www.itunes.com/dtds/post-1.0.dtd") { 
  xml.channel{
    xml.title("Vivatjesus")
    xml.link("http://www.vivatjesus.com/")
    xml.language("en-us")
    xml.copyright("Copyright 2007 Chris Matthieu")
    xml.itunes :subtitle, "Study of Ruby on Rails by Chris Matthieu"
    xml.itunes :author, "Chris Matthieu"
    xml.itunes :summary, "The Vivatjesus post is a series of lessons learned by Chris Matthieu on his endeavor of switching from Microsoft .NET programming to Ruby on Rails.  Believe it or not, there are similarities between both Micorost ASP and .NET and Ruby on Rails.  Let Chris show you how to get up and running on Rails and become proficient with Ruby with little effort.  Learn AJAX tricks, tagging, buddy lists, rating, and other Web 2.0 social network programming techniques and get your idea to market today!  While you are at it, check out the Vivatjesus.com website for code snippets and additional show information."
    xml.description("The Vivatjesus post is a series of lessons learned by Chris Matthieu on his endeavor of switching from Microsoft .NET programming to Ruby on Rails.  Believe it or not, there are similarities between both Micorost ASP and .NET and Ruby on Rails.  Let Chris show you how to get up and running on Rails and become proficient with Ruby with little effort.  Learn AJAX tricks, tagging, buddy lists, rating, and other Web 2.0 social network programming techniques and get your idea to market today!  While you are at it, check out the Vivatjesus.com website for code snippets and additional show information.")
		
    xml.itunes :owner do
      xml.itunes :name,"Chris Matthieu"
      xml.itunes :email,"chris@vivatjesus.com"
    end

    xml.itunes :image,:href=>"http://vivatjesus.com/images/vivatjesus.jpg"
    xml.itunes :explicit, 'clean' 
    		
  
  
		xml.itunes :category,:text=>'Technology' do
			xml.itunes :category,:text=>'Software How-To'
		end    
		
    for post in @posts
      xml.item do
        
        if post.podurl == "mov"
          @url = "http://vivatjesus.com/mp3s/vivatjesus" + post.id.to_s + ".mov"
          #@url = "http://s3.amazonaws.com/vivatjesus/vivatjesus" + post.id.to_s + ".mov"
          
        elsif post.podurl.blank? or post.podurl == "mp3"
          @url = "http://vivatjesus.com/mp3s/vivatjesus" + post.id.to_s + ".mp3"
        else
          @url = post.podurl
          #@url = "http://s3.amazonaws.com/vivatjesus/vivatjesus" + post.id.to_s + ".mp3"
        end
      
        xml.title(post.podname)
        xml.itunes :author, "Chris Matthieu"
        xml.itunes :subtitle, post.poddesc #"Study of Ruby on Rails"
        xml.itunes :summary, post.poddesc
        xml.description(post.poddesc)
        if post.podurl == "mov"
          xml.enclosure(:url=>@url, :type=>"video/quicktime") #add length
        else
          xml.enclosure(:url=>@url, :type=>"audio/mpeg") #add length
        end
        xml.guid(@url)
        # xml.pubDate(post.created_at.rfc2822)
        xml.pubDate(post.created_at) #.strftime("%A, %d %B %Y %I:%M:%S %z"))
        xml.itunes :duration, "15:00" #add duration to database entry
        xml.itunes :keywords, "ruby,rails,ruby on rails,programming,web 2.0,vivatjesus" #add keywords to database entry
      end
    end
  }
}