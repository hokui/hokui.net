class Api::ProfilesController < Api::ApplicationController
  def show
    render json: @current_user
  end
end
