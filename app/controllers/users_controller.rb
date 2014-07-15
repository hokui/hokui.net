class UsersController < ApplicationController
  def activate
    user = User.load_from_activation_token(params[:activation_token])
    if user && user.email_local == params[:email_local]
      user.activate!
      redirect_to QueryString.generate_url("/", activation_success: true)
    else
      redirect_to QueryString.generate_url("/", activation_success: false)
    end
  end
end
