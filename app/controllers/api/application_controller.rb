class Api::ApplicationController < ActionController::API
  before_action :require_login_with_token

  private

  def require_login_with_token
    @access_token = AccessToken.find_by(token: params[:token])

    if @access_token
      unless defined?(@current_user)
        @current_user = @access_token.user
      end
      @current_user
    else
      head 401
    end
  end
end
