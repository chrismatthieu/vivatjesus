class Notifier < ActionMailer::Base
  default :from => "admin@vivatjes.us"
  
  def contact(toemail, fromemail, message)
    
    mail( :to => toemail,
          :bcc => ["bcc@example.com", "Order Watcher <watcher@example.com>"],
          :subject => "Vivat Jesus!",
          :body => message)
             
  end
  
end
