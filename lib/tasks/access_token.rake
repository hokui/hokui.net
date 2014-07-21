desc "delete all expired access tokens"
task "access_token:delete_expired_tokens" => :environment do
  AccessToken.delete_expired
end
