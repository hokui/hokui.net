class Api::SessionsController < Api::ApplicationController
  skip_before_action :require_login_with_token, only: :create

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
end
