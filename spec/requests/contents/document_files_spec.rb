require 'rails_helper'

RSpec.describe "DocumentFiles", type: :request do
  describe "GET /contents/document_files/1" do
    it "sends the document file" do
      df = create(:document_file)
      dt = DownloadToken.last
      get("/contents/document_files/#{df.id}?download_token=#{dt.token}")
      expect(response.status).to eq(200)
      expect(response.body).to eq(File.binread(File.join(Rails.root, "misc", "uploaded", "000001-dummy.pdf")))
    end

    it "returns 401 if the download token is expired" do
      df = create(:document_file)
      dt = DownloadToken.last
      dt.created_at = Time.now - 3.days
      dt.save!
      get("/contents/document_files/#{df.id}?download_token=#{dt.token}")
      expect(response.status).to eq(401)
      expect(response.body).to eq("Download not authorized")
      dt.created_at = Time.now
      dt.save!
    end

    it "returns 404 if specified document file is missing" do
      dt = create(:download_token)
      get("/contents/document_files/1000?download_token=#{dt.token}")
      expect(response.status).to eq(404)
      expect(response.body).to eq("File not found")
    end
  end
end
