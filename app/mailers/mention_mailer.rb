class MentionMailer < ActionMailer::Base
  default from: "noreply@vivatjes.us"
  # rails g mailer mention_mailer alerter

  def alerter(fromcall, tocall, photo, email, activityid)
    @fromcall = fromcall
    @tocall = tocall
    @photo = photo
    @activityid = activityid
    mail to: email, subject: @fromcall.upcase + " Mentioned You on VivatJesus", :from => "noreply@vivatjes.us"
  end
end
