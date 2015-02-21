require 'rails_helper'

RSpec.describe "DocumentFiles", type: :request do
  before do
    @guest = create_guest_with_token
  end

  describe "GET /api/subjects/1/documents/1/document_files" do
    before(:all) do
      @sub = create(:subject)
      @doc = create(:document, subject_id: @sub.id)
      @df = create(:document_file, document_id: @doc.id)
    end

    it "returns a list of document files which belong to the document" do
      get_with_token(@guest, "/api/subjects/#{@sub.id}/documents/#{@doc.id}/document_files")
      expect(response.status).to eq(200)
      expect(json.first["file_name"]).to eq(@df.file_name)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/subjects/#{@sub.id}/documents/#{@doc.id}/document_files")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/document_files" do
    before do
      @filepath = File.join(Rails.root, "misc", "uploaded", "000001-dummy.pdf")
      @json_params = {
        subject_id: 1,
        class_year: 93,
        code: 1,
        user_id: @guest.id,
        comments: "hoge"
      }
    end

    it "creates an AR record and saves uploaded file" do
      old_size = DocumentFile.count
      post_with_token(
        @guest,
        "/api/document_files",
        file: fixture_file_upload(@filepath, "application/pdf"),
        json: @json_params.to_json
      )
      expect(response.status).to eq(201)
      expect(DocumentFile.count).to eq(old_size + 1)
      df_id = json["id"]
      expect(File.binread("/tmp/#{sprintf("%06d", df_id)}-000001-dummy.pdf")).to eq(File.binread(@filepath))
    end

    it "returns 422 if uploaded file is missing" do
      pending "can't handle unexpected error"
      fail
      # TODO: following code raises ActionDispatch::ParamsParser::ParseError
      # post_with_token(
      #   @guest,
      #   "/api/document_files",
      #   json: @json_params.to_json
      # )
      # expect(response.status).to eq(422)
    end

    it "returns 422 with invalid params" do
      @json_params.delete(:code)
      old_size = DocumentFile.count
      post_with_token(
        @guest,
        "/api/document_files",
        file: fixture_file_upload(@filepath, "application/pdf"),
        json: @json_params.to_json
      )
      expect(response.status).to eq(422)
      expect(DocumentFile.count).to eq(old_size)
    end

    it "returns 401 to an unauthorized client" do
      old_size = DocumentFile.count
      post(
        "/api/document_files",
        file: fixture_file_upload(@filepath, "application/pdf"),
        json: @json_params.to_json
      )
      expect(response.status).to eq(401)
      expect(DocumentFile.count).to eq(old_size)
    end
  end

  describe "GET /api/document_files/1/download_token" do
    it "creates new DownloadToken and returns it" do
      df = create(:document_file)
      get_with_token(@guest, "/api/document_files/#{df.id}/download_token")
      expect(json["token"]).to eq(df.download_tokens.last.token)
    end
  end
end
