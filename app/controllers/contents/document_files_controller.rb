class Contents::DocumentFilesController < Contents::ApplicationController
  def render_file
    begin
      @document_file = DocumentFile.find(params[:id])
    rescue
      # TODO
      render text: "File not found", status: 404
      return
    end

    if authorize_download
      @document_file.download_count += 1
      @document_file.save!
      filepath = @document_file.file_fullpath
      filename = ERB::Util.url_encode(@document_file.file_name)
      filesize = File.stat(filepath).size
      send_file filepath, filename: filename, length: filesize, disposition: "inline"
    else
      # TODO
      render text: "Download not authorized", status: 401
    end
  end

  private

  def authorize_download
    download_token = DownloadToken.find_token(params[:download_token])
    if download_token
      true
    else
      false
    end
  end
end
