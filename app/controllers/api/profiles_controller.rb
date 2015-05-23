class Api::ProfilesController < Api::ApplicationController
  def show
    render json: @current_user
  end

  def update
    if @current_user.update_attributes(profile_params)
      render json: @current_user, status: 200
    else
      render json: @current_user, status: 422
    end
  end

  private

  def profile_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
      permit(
        :class_year_id,
        :handle_name,
        :birthday,
        :email_mobile
      )
  end
end
