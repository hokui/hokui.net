class PasswordResetsController < Api::ApplicationController
  skip_before_action :require_login_with_token

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.deliver_reset_password_instructions!
      head 200
    else
      head 404
    end
  end

  def update
    @user = User.load_from_reset_password_token(params[:reset_password_token])

    unless @user
      head 404
      return
    end

    if @user.change_password!(params[:new_password])
      head 200
    else
      head 400
    end
  end

  private

  def params
    JSON.parse(request.body.read)
  end
end
