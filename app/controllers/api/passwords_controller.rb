class Api::PasswordsController < Api::ApplicationController
  class BlankPasswordError < StandardError; end

  def update
    unless User.authenticate(@current_user.email, params[:current_password])
      render json: { errors: { current_password: ["is wrong"] } }, status: 401
      return
    end
    @current_user.change_password!(password_params[:password])
    render json: @current_user, status: 200
  rescue BlankPasswordError
    @current_user.errors.add(:password, "can't be blank")
    render json: @current_user, status: 422
  end

  private

  def password_params
    params = ActionController::Parameters.new(JSON.parse(request.body.read)).
      permit(
        :current_password,
        :password
      )
    if params[:password].blank?
      raise BlankPasswordError
    else
      return params
    end
  end
end
