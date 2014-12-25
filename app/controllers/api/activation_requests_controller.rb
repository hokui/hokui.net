class Api::ActivationRequestsController < Api::ApplicationController
  skip_before_action :require_login_with_token

  def create
    @user = User.find_by(email: params[:email])
    if @user
      @user.send_activation_needed_email!
      head 200
    else
      head 404
    end
  end

  private

  def params
    ActionController::Parameters.new(JSON.parse(request.body.read))
  end
end
