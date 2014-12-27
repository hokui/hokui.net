class Api::DocumentsController < Api::ApplicationController
  before_action :set_document, only: :download_token

  def create
    @document = Document.new(document_params).attach_file(file_params)
    if @document.save
      render json: @document, status: 201
    else
      render json: @document, status: 422
    end
  end

  def download_token
    @document.generate_download_token!
    render json: @document, status: 201
  end

  private

  def set_document
    @document = Document.find(params[:id])
  end

  def file_params
    params["file"]
  end

  def document_params
    ActionController::Parameters.new(JSON.parse(params["json"])).
      permit(
        :subject_id,
        :user_id,
        :class_year,
        :document_type,
        :number,
        :with_answer,
        :note
      )
  end
end
