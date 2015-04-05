class UserMailer < ActionMailer::Base
  default from: "admin@hokui.net"

  def email_confirmation_on_create(user)
    @user = user
    mail to: user.email, subject: '北医ネットへようこそ！'
  end

  def approved_notification(user)
    @user = user
    mail to: user.email, subject: '北医ネットへようこそ！'
  end

  def reset_password_instructions(user)
    @user = user
    mail to: user.email, subject: '[北医ネット] パスワード再設定URLをお知らせします'
  end
end
