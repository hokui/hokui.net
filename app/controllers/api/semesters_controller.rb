class Api::SemestersController < Api::ApplicationController
  before_action :set_semester, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @semesters = if params[:class_year_id]
                   Semester.where(class_year_id: params[:class_year_id])
                 else
                   Semester.all
                 end
    render json: @semesters
  end

  def show
    render json: @semester
  end

  def create
    @semester = Semester.new(semester_params)
    authorize @semester
    if @semester.save
      render json: @semester, status: 201
    else
      render json: @semester, status: 422
    end
  end

  def update
    authorize @semester
    if @semester.update_attributes(semester_params)
      render json: @semester, status: 200
    else
      render json: @semester, status: 422
    end
  end

  def destroy
    authorize @semester
    @semester.destroy
    head 200
  end

  private

  def set_semester
    @semester = Semester.find(params[:id])
  end

  def semester_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
    permit(
      :class_year_id,
      :identifier,
      :subject_ids => []
    )
  end
end
