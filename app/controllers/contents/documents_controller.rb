class Contents::DocumentsController < ActionController::Base
  before_action :set_document, only: :show

  def show
    if @document
      if authorize_download
        filepath = @document.file_fullpath
        filename = ERB::Util.url_encode(@document.file_name)
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

  def set_document
    @document = Document.find(params[:id])
  end

  def authorize_download
    download_token = DownloadToken.find_by(token: params[:download_token])
    if download_token && download_token.document_id == @document.id
      download_token.destroy!
      true
    else
      false
    end
  end
end
