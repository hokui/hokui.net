class Api::ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :require_login_with_token

  private

  def require_login_with_token
    @access_token = AccessToken.find_token(params[:token])

    if @access_token
      unless defined?(@current_user)
        @current_user = @access_token.user
      end
      @current_user
    else
      head 401
    end
  end

  def current_user
    @current_user
  end

  def user_not_authorized
    head 403
  end
end
