class Api::DocumentsController < Api::ApplicationController
  # NOTE actions in this controller should be called as
  #   /api/subjects/1/documents
  # but not
  #   /api/documents

  before_action :set_document, only: :show

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

  private

  def set_document
    @document = Subject.find(params[:subject_id]).documents.find(params[:id])
  rescue
    head 404
  end
end
