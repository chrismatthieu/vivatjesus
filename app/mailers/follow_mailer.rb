class FollowMailer < ActionMailer::Base
  default from: "noreply@73s.com"
  # rails g mailer follow_mailer alerter

  def alerter(fromcall, tocall, photo, email)
    @fromcall = fromcall
    @tocall = tocall
    @photo = photo
    mail to: email, subject: "New VivatJesus Follower", :from => "noreply@73s.com"
  end
end
