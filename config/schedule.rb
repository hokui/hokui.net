env :PATH, ENV['PATH']

set :output, "log/cron.log"

every 1.day, at: "9:00 am" do
  runner "User.send_approval_request_to_admin!"
end

every 1.day, at: "9:00 am" do
  runner "DownloadToken.delete_expired!"
end

every :saturday, at: "3:00 am" do
  runner "AccessToken.delete_expired!"
end
