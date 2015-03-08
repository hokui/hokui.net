class Api::DocumentFilesController < Api::ApplicationController
  before_action :find_or_create_document, only: [:create, :update]
  before_action :set_document_file, only: [:show, :update, :destroy, :download_token]
  after_action :verify_authorized , except: [:index, :show, :create, :download_token]

  def index
    # NOTE this action is intended to be called as
    #   /api/subjects/1/documents/1/document_files
    # but not
    #   /api/document_files
    document = Subject.find(params[:subject_id]).documents.find(params[:document_id])
    @document_files = DocumentFile.where(document_id: document.id)
    render json: @document_files
  end

  def show
    render json: @document_file
  end

  def create
    @document_file = @document.document_files.new(document_file_params).attach_file(file_params)
    if @document_file.save_with_file
      render json: @document_file, status: 201
    else
      render json: @document_file, status: 422
    end
  end

  def update
    authorize @document_file
    @document_file.assign_attributes(document_file_params.merge(document_id: @document.id))
    @document_file.attach_file(file_params) if file_params
    if @document_file.save
      render json: @document_file, status: 200
    else
      render json: @document_file, status: 422
    end
  end

  def destroy
    authorize @document_file
    @document_file.destroy
    head 200
  end

  def download_token
    render json: @document_file.generate_download_token!, status: 201
  end

  private

  def find_or_create_document
    # NOTE this before_action might return an instance of Document and prevent
    # original action from returning a instance of DocumentFile
    @document = Document.where(
      subject_id: document_params[:subject_id],
      class_year: document_params[:class_year],
      code:       document_params[:code]
    ).first_or_initialize
    unless @document.save
      render json: @document, status: 422
      return
    end
  end

  def file_params
    params["file"]
  end

  def json_params
    ActionController::Parameters.new(JSON.parse(params["json"]))
  end

  def document_params
    json_params.
      permit(
        :subject_id,
        :class_year,
        :code,
      )
  end

  def document_file_params
    json_params.
      permit(
        :user_id,
        :comments
      )
  end

  def set_document_file
    @document_file = DocumentFile.find(params[:id])
  end
end
