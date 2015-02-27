require 'rails_helper'

RSpec.describe "DocumentFiles", type: :request do
  before(:all) do
    @admin = create_admin_with_token
    @guest = create_guest_with_token
    @sub = create(:subject)
    @doc = create(:document, subject_id: @sub.id)
    @df = create(:document_file, document_id: @doc.id, user_id: @guest.id)
  end

  describe "GET /api/subjects/1/documents/1/document_files" do
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

  describe "GET /api/document_files/1" do
    it "returns a document file" do
      get_with_token(@guest, "/api/document_files/#{@df.id}")
      expect(response.status).to eq(200)
      expect(json["file_name"]).to eq(@df.file_name)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/document_files/#{@df.id}")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/document_files" do
    before do
      @filepath = File.join(Rails.root, "misc", "uploaded", "000002-dummy.pdf")
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
      expect(File.binread("/tmp/#{sprintf("%06d", df_id)}-000002-dummy.pdf")).to eq(File.binread(@filepath))
    end

    it "returns 422 if uploaded file is missing" do
      pending "can't handle unexpected error"

      # TODO: following code raises ActionDispatch::ParamsParser::ParseError
      post_with_token(
        @guest,
        "/api/document_files",
        json: @json_params.to_json
      )
      expect(response.status).to eq(422)
    end

    it "returns 422 with invalid params" do
      @json_params.delete(:class_year)
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

  describe "PATCH /api/document_files/1" do
    before do
      @filepath = File.join(Rails.root, "misc", "uploaded", "000002-dummy.pdf")
      @json_params = {
        subject_id: 2,
        class_year: 93,
        code: 1001,
        user_id: @guest.id,
        comments: "hoge"
      }
    end

    # NOTE these lines will be required when following failed specs are fixed
    # after(:all) do
    #   @df = create(:document_file)
    # end

    it "updates a document file attributes" do
      pending "can't handle unexpected error"

      # TODO: following code raises ActionDispatch::ParamsParser::ParseError
      patch_with_token(
        @guest,
        "/api/document_files/#{@df.id}",
        json: @json_params.to_json
      )
      expect(response.status).to eq(200)
      expect(json["code"]).to eq(1001)
    end

    it "updates a document file" do
      pending "can't handle unexpected error"

      # TODO: following code raises ActionDispatch::ParamsParser::ParseError
      patch_with_token(
        @guest,
        "/api/document_files/#{@df.id}",
        file: fixture_file_upload(@filepath, "application/pdf")
      )
      expect(response.status).to eq(200)
      expect(response.file_name).to eq("000002-dummy.pdf")
      df_id = json["id"]
      expect(File.binread("/tmp/#{sprintf("%06d", df_id)}-000002-dummy.pdf")).to eq(File.binread(@filepath))
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

  describe "DELETE /api/document_files/1" do
    it "deletes the document file" do
      old_size = DocumentFile.count
      delete_with_token(@guest, "/api/document_files/#{@df.id}")
      expect(response.status).to eq(200)
      expect(DocumentFile.count).to eq(old_size - 1)
    end

    it "returns 403 to the guest who is not the owner of the file" do
      @df.user_id = @guest.id + 10
      @df.save

      old_size = DocumentFile.count
      delete_with_token(@guest, "/api/document_files/#{@df.id}")
      expect(response.status).to eq(403)
      expect(DocumentFile.count).to eq(old_size)

      @df.user_id = @guest.id
      @df.save
    end

    it "returns 401 to an unauthorized client" do
      old_size = DocumentFile.count
      delete("/api/document_files/#{@df.id}")
      expect(response.status).to eq(401)
      expect(DocumentFile.count).to eq(old_size)
    end
  end

  describe "GET /api/document_files/1/download_token" do
    it "creates new DownloadToken and returns it" do
      get_with_token(@guest, "/api/document_files/#{@df.id}/download_token")
      expect(json["token"]).to eq(@df.download_tokens.last.token)
    end
  end
end
