class Api::ApplicationController < ActionController::API
  include Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  include Sorcery::Controller
  before_action :require_login_with_token, except: :not_found

  def not_found
    head 404
  end

  def default_serializer_options
    { root: false }
  end

  private

  def require_login_with_token
    token = request.headers["Access-Token"]
    @access_token = AccessToken.find_token(token)

    unless @access_token
      head 401
      return
    end

    unless defined?(@current_user)
      @current_user = @access_token.user
    end

    if @current_user.active? && @current_user.approved?
      @current_user
    else
      @access_token.destroy!
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
