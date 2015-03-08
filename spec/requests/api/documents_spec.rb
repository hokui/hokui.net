require 'rails_helper'

RSpec.describe "Documents", type: :request do
  before(:all) do
    sub1 = create(:subject)
    sub2 = create(:subject)
    create(:subject, id: 10)

    @doc1 = create(:document, subject_id: sub2.id, code: 2001)
    @doc2 = create(:document, subject_id: sub1.id, code:    3)
    create(:document, subject_id: sub2.id, code: 4001)
    create(:document, subject_id: sub2.id, code: 1001)
    create(:document, subject_id: sub1.id, code: 3011)
    create(:document, subject_id: sub1.id, code: 4002)
    create(:document, subject_id: sub2.id, code:    2)
    create(:document, subject_id: sub2.id, code: 5000)
    create(:document, subject_id: sub1.id, code:    1)
    create(:document, subject_id: sub1.id, code: 1099)

    @admin = create_admin_with_token
    @guest = create_guest_with_token
  end

  describe "GET /api/subjects/1/documents" do
    it "returns a list of documents", autodoc: true do
      get_with_token(@guest, "/api/subjects/1/documents")
      expect(response.status).to eq(200)
      expect(json.map { |e| e["code"] }).to eq([1, 3, 1099, 3011, 4002])
    end

    it "returns a list of documents with given range of code", autodoc: true do
      get_with_token(@guest, "/api/subjects/1/documents?code=0-1999")
      expect(response.status).to eq(200)
      expect(json.map { |e| e["code"] }).to eq([1, 3, 1099])
    end

    it "returns 401 to an unauthorized client" do
      get("/api/subjects/1/documents")
      expect(response.status).to eq(401)
    end
  end

  describe "GET /api/subjects/1/documents/1" do
    it "returns a document", autodoc: true do
      get_with_token(@guest, "/api/subjects/#{@doc1.subject_id}/documents/#{@doc1.id}")
      expect(response.status).to eq(200)
      expect(json["code"]).to eq(2001)
    end

    it "returns 404 if the specified document does not belong to the subject" do
      get_with_token(@guest, "/api/subjects/10/documents/#{@doc1.id}")
      expect(response.status).to eq(404)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/subjects/#{@doc1.subject_id}/documents/#{@doc1.id}")
      expect(response.status).to eq(401)
    end
  end
end

