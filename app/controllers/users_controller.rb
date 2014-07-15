class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    @user.save
    render json: @user
  end

  private

  def user_params
    json_params = ActionController::Parameters.new(
      JSON.parse(request.body.read)
    )
    graduation_year =
      GraduationYear.find_by(year: json_params[:user][:class_year] + 1924)
    json_params.
      require(:user).
      permit(
        :email,
        :password,
        :family_name,
        :given_name,
        :handle_name,
        :birthday,
        :email_mobile
      ).
      merge(graduation_year: graduation_year)
  end
end
