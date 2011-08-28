class Notifier < ActionMailer::Base
  # default :from => "admin@vivatjes.us"
  
  def contact(toemail, fromemail, message)
    
    mail( :to => toemail,
          :from => fromemail,
          :subject => "Vivat Jesus!",
          :body => message)
             
  end
  
end
