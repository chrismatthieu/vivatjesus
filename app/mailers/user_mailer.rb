class UserMailer < ActionMailer::Base
  default from: "noreply@VivatJes.us"

  def password_reset(user)
    @user = user
    mail :to => user.email, :subject => "VivatJes.us Password Reset"
  end
end
