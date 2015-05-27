env :PATH, ENV['PATH']

set :output, "log/cron.log"

every 1.day, at: "9:00 am" do
  runner "User.send_approval_request_to_admin!"
  runner "DownloadToken.create!"
  runner "DownloadToken.delete_expired!"
  runner "AccessToken.delete_expired!"
end
