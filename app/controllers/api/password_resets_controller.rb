class Api::PasswordResetsController < Api::ApplicationController
  class BlankPasswordError < StandardError; end

  skip_before_action :require_login_with_token

  def create
    @user = User.find_by(email: raw_params[:email])
    if @user
      @user.generate_reset_password_token!
      @user.send_reset_password_instructions!
      head 200
    else
      head 404
    end
  end

  def update
    @user = User.load_from_reset_password_token(raw_params[:reset_password_token])

    unless @user
      head 404
      return
    end

    @user.change_password!(password_params[:password])
    render json: @user, status: 200
  rescue BlankPasswordError
    @user.errors.add(:password, "can't be blank")
    render json: @user, status: 422
  end

  private

  def raw_params
    @raw_params ||= ActionController::Parameters.new(JSON.parse(request.body.read))
  end

  def password_params
    if raw_params[:password].blank?
      raise BlankPasswordError
    else
      return raw_params
    end
  end
end
