class Api::SessionsController < Api::ApplicationController
  skip_before_action :require_login_with_token

  def create
    json_hash = JSON.parse(request.body.read)
    email    = json_hash["email"]
    password = json_hash["password"]

    user = User.authenticate(email, password)
    if user
      access_token = AccessToken.create(user: user)
      render json: {
        token: access_token.token,
        user: UserSerializer.new(user)
      },
      status: 201,
      root: false
    else
      head 422
    end
  end

  def destroy
    token = request.headers["Access-Token"]
    access_token = AccessToken.find_token(token)
    access_token.destroy if access_token
    head 200
  end
end
