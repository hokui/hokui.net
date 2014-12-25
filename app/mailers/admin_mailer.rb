class AdminMailer < ActionMailer::Base
  default from: "admin@hokui.net"

  def approval_request(admins, users_waiting_approval)
    @users = users_waiting_approval
    headers["X-MC-PreserveRecipients"] = "false"
    mail to: admins.map(&:email), subject: '[北医ネット] 新しい承認申請があります'
  end
end
