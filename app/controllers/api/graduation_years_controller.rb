class Api::GraduationYearsController < Api::ApplicationController
  before_action :set_graduation_year, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @graduation_years = GraduationYear.all
    render json: @graduation_years
  end

  def show
    render json: @graduation_year
  end

  def create
    @graduation_year = GraduationYear.new(graduation_year_params)
    authorize @graduation_year
    if @graduation_year.save
      render json: @graduation_year, status: 201
    else
      render json: @graduation_year, status: 422
    end
  end

  def update
    authorize @graduation_year
    if @graduation_year.update(graduation_year_params)
      head 200
    else
      render json: @graduation_year, status: 422
    end
  end

  def destroy
    authorize @graduation_year
    @graduation_year.destroy
    head 200
  end

  private

  def set_graduation_year
    @graduation_year = GraduationYear.find(params[:id])
  end

  def graduation_year_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
    require(:graduation_year).
    permit(
      :year
    )
  end
end
