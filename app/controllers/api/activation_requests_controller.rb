class Api::ActivationRequestsController < Api::ApplicationController
  skip_before_action :require_login_with_token

  def create
    @user = User.find_by(email: params[:email])

    unless @user
      render json: {}, status: 400
      return
    end

    if @user.active?
      render json: { approval_state: @user.approval_state }, status: 400
    else
      @user.send_activation_needed_email!
      head 200
    end
  end

  private

  def params
    ActionController::Parameters.new(JSON.parse(request.body.read))
  end
end
