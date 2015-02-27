class Api::DocumentsController < Api::ApplicationController
  # NOTE actions in this controller should be called as
  #   /api/subjects/1/documents
  # but not
  #   /api/documents

  before_action :set_document, only: [:show, :update, :destroy]
  after_action :verify_authorized, except: [:index, :show]

  def index
    @documents = if params[:code]
                   code_range = Range.new(*params[:code].split("-").map(&:to_i))
                   Document.where(code: code_range)
                 else
                   Document.all
                 end
    @documents = @documents.where(subject_id: params[:subject_id]).order(code: :asc)
    render json: @documents
  end

  def show
    render json: @document
  end

  def update
    authorize @document
    if @document.update_attributes(document_params)
      render json: @document, status: 200
    else
      render json: @document, status: 422
    end
  end

  def destroy
    authorize @document
    @document.destroy
    head 200
  end

  private

  def set_document
    @document = Subject.find(params[:subject_id]).documents.find(params[:id])
  rescue
    head 404
  end

  def document_params
    ActionController::Parameters.new(JSON.parse(request.body.read)).
      permit(
        :subject_id,
        :class_year,
        :code
    )
  end
end
