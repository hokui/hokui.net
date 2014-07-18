class UserMailer < ActionMailer::Base
  default from: "admin@hokui.net"

  def email_confirmation_on_create(user)
    @user = user
    mail to: user.email, subject: '北医ネットへようこそ！'
  end
end
