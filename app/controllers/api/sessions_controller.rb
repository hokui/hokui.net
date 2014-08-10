class Api::SessionsController < Api::ApplicationController
  skip_before_action :require_login_with_token

  def create
    json_hash = JSON.parse(request.body.read)
    email    = json_hash["email"]
    password = json_hash["password"]

    user = User.authenticate(email, password)
    if user
      access_token = AccessToken.create(user: user)
      render json: { logged_in: true, token: access_token.token }, status: 201
    else
      render json: { logged_in: false }, status: 422
    end
  end

  def destroy
    token = request.headers["Access-Token"]
    access_token = AccessToken.find_token(token)

    if access_token
      access_token.destroy
      render json: { logged_out: true }, status: 200
    else
      render json: { logged_out: false }, status: 200
    end
  end
end
