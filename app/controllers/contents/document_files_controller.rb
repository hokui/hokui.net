class Contents::DocumentFilesController < ActionController::Base
  before_action :set_document_file, only: :show

  def show
    if @document_file
      if authorize_download
        filepath = @document_file.file_fullpath
        filename = ERB::Util.url_encode(@document_file.file_name)
        filesize = File.stat(filepath).size
        send_file(filepath, filename: filename, length: filesize)
      else
        # TODO
        render text: "Download not authorized", status: 401
      end
    else
      # TODO
      render text: "File not found", status: 404
    end
  end

  private

  def set_document_file
    @document_file = DocumentFile.find(params[:id])
  end

  def authorize_download
    download_token = DownloadToken.find_token(params[:download_token])
    if download_token && download_token.document_file_id == @document_file.id
      download_token.destroy!
      true
    else
      false
    end
  end
end
