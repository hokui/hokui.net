require 'rails_helper'

RSpec.describe "DocumentFiles", type: :request do
  describe "GET /contents/document_files/1" do
    it "sends the document file" do
      df = create(:document_file)
      dt = df.generate_download_token!
      get("/contents/document_files/#{df.id}?download_token=#{dt.token}")
      expect(response.status).to eq(200)
      expect(response.body).to eq(File.binread(File.join(Rails.root, "misc", "uploaded", "000001-dummy.pdf")))
    end
  end
end
