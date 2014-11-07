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

  for method in ['post', 'put', 'patch'] do
    module_eval %{
      def raw_#{method}(path, body, headers_or_env = {})
        response = #{method}(path, {}, { "RAW_#{method.upcase}_DATA" => body }.merge(headers_or_env))
        @request.env.delete("RAW_#{method.upcase}_DATA")
        response
      end
    }
  end

  for method in ['get', 'post', 'put', 'patch', 'delete', 'raw_post', 'raw_put', 'raw_patch'] do
    module_eval %{
      def #{method}_with_token(user, path, parameters = nil, headers_or_env = {})
        #{method}(path, parameters, { "CONTENT_TYPE" => "application/json", "ACCEPT" => "application/json", "Access-Token" => user.access_tokens.first.token }.merge(headers_or_env))
      end
    }
  end

  def json
    @json ||= JSON.parse(response.body)
  end
end
