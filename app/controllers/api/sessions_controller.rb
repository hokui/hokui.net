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
        user: UserSerializer.new(@current_user)
      },
      status: 201,
      root: false
    else
      after_failed_login!([])
      head 422
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
