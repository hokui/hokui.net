class Api::UsersController < Api::ApplicationController
  skip_before_action :require_login_with_token, only: [:create, :activate]
  before_action :set_user, only: [:show, :approve]
  after_action :verify_authorized, except: [:create, :profile, :activate]

  def index
    @users = User.all
    authorize User
    render json: @users
  end

  def show
    authorize @user
    render json: @user
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user, status: 201
    else
      render json: @user, status: 422
    end
  end

  def profile
    render json: @current_user
  end

  def activate
    params = ActionController::Parameters.new(JSON.parse(request.body.read))
    user = User.load_from_activation_token(params[:activation_token])
    if user && user.email_local == params[:email_local]
      user.activate!
      head 200
    else
      head 400
    end
  end

  def approve
    authorize @user
    @user.approve!
    head 200
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    json_params = ActionController::Parameters.new(
      JSON.parse(request.body.read)
    )
    class_year =
      ClassYear.find_by(year: json_params[:user][:class_year])
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
      merge(class_year: class_year)
  end
end
