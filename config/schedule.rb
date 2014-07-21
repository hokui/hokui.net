env :PATH, ENV['PATH']

set :output, "log/cron.log"

every :saturday, at: "3am" do
  rake "access_token:delete_expired_tokens"
end
