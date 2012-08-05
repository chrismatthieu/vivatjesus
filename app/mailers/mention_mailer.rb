class MentionMailer < ActionMailer::Base
  default from: "noreply@73s.com"
  # rails g mailer mention_mailer alerter

  def alerter(fromcall, tocall, photo, email, activityid)
    @fromcall = fromcall
    @tocall = tocall
    @photo = photo
    @activityid = activityid
    mail to: email, subject: @fromcall.upcase + " Mentioned You on VivatJesus", :from => "noreply@73s.com"
  end
end
