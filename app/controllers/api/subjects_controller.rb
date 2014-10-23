class Api::SubjectsController < Api::ApplicationController
  before_action :set_subject, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @subjects = Subject.all
    render json: @subjects
  end

  def show
    render json: @subject
  end

  def create
    @subject = Subject.new(subject_params)
    authorize @subject
    if @subject.save
      render json: @subject, status: 201
    else
      render json: @subject, status: 422
    end
  end

  def update
    authorize @subject
    if @subject.update(subject_params)
      render json: @subject, status: 200
    else
      render json: @subject, status: 422
    end
  end

  def destroy
    authorize @subject
    @subject.destroy
    head 200
  end

  private

  def set_subject
    @subject = Subject.find(params[:id])
  end

  def subject_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
    permit(
      :title_ja,
      :title_en
    )
  end
end
