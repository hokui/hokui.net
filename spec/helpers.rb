module Helpers
  def create_admin_with_token
    admin = create(:admin)
    admin.access_tokens.create!
    admin
  end

  def create_guest_with_token
    guest = create(:guest)
    guest.access_tokens.create!
    guest
  end

  for method in ['get', 'post', 'put', 'patch', 'delete'] do
    module_eval %{
      def #{method}_with_token(user, path, parameters = nil, headers_or_env = {})
        #{method}(path, parameters, { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Access-Token" => user.access_tokens.first.token }.merge(headers_or_env))
      end
    }
  end
end
