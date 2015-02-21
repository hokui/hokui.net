class Api::DocumentFilesController < Api::ApplicationController
  before_action :set_document_file, only: :download_token

  def create
    # NOTE this action returns either Document or DocumentFile
    @document = Document.where(document_params).first_or_initialize
    unless @document.save
      render json: @document, status: 422
      return
    end
    @document_file = @document.document_files.new(document_file_params).attach_file(file_params)
    if @document_file.save_with_file
      render json: @document_file, status: 201
    else
      render json: @document_file, status: 422
    end
  end

  def download_token
    render json: @document_file.generate_download_token!, status: 201
  end

  private

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
