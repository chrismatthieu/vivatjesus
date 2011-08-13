xml.instruct! :xml, :version=>"1.0" 
xml.rss :version => "2.0" do 
  xml.channel do
    xml.title "VivatJesus"
    xml.link "http://VivatJes.us/"
    xml.language "en-us"
    xml.copyright "Copyright 2011 KofC Council 10062"
    xml.description "Knights of Columbus Chorpus Christi Council 10062."

    for post in @posts
      xml.item do
        
        @url = "http://vivatjes.us/posts/" + post.id.to_s 
      
        xml.title post.postname
        xml.description post.postbody
        xml.enclosure :url=>@url
        xml.guid @url
        xml.pubDate(post.created_at.rfc2822)
        # xml.pubDate(podcast.created_at.strftime("%A, %d %B %Y %I:%M:%S %z"))
      end
    end
  end
end