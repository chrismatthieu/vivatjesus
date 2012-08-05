class FollowMailer < ActionMailer::Base
  default from: "noreply@vivatjes.us"
  # rails g mailer follow_mailer alerter

  def alerter(fromcall, tocall, photo, email)
    @fromcall = fromcall
    @tocall = tocall
    @photo = photo
    mail to: email, subject: "New VivatJesus Follower", :from => "noreply@vivatjes.us"
  end
end
