class Api::DocumentFilesController < Api::ApplicationController
  def create
    document = Document.where(document_params).first_or_create!
    @document_file = document.document_files.new(document_file_params).attach_file(file_params)
    if @document_file.save
      render json: @document_file, status: 201
    else
      render json: @document_file, status: 422
    end
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
end
