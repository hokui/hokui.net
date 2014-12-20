class Api::SessionsController < Api::ApplicationController
  skip_before_action :require_login_with_token

  def create
    json_hash = JSON.parse(request.body.read)
    email    = json_hash["email"]
    password = json_hash["password"]

    @current_user = User.authenticate(email, password)
    if @current_user
      access_token = AccessToken.create(user: @current_user)
      after_login!(@current_user)
      render json: {
        token: access_token.token,
        # NOTE: UserSerializer.new(...).as_json does not work properly.
        # There may be cool methods to do this, but this does work.
        user: UserSerializer.new(@current_user, root: false).attributes.as_json
      },
      status: 201
    else
      after_failed_login!([])
      head 401
    end
  end

  def destroy
    token = request.headers["Access-Token"]
    if access_token = AccessToken.find_token(token)
      before_logout!(access_token.user)
      access_token.destroy!
      after_logout!
    end
    head 200
  end
end
