require 'rails_helper'

RSpec.describe "Subjects", :type => :request do
  describe "GET /api/subjects" do
    it "returns a list of subjects", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/subjects")
      expect(response.status).to eq(200)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/subjects")
      expect(response.status).to eq(401)
    end
  end

  describe "GET /api/subjects/1" do
    before do
      create(:subject)
    end

    it "returns subject", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/subjects/1")
      expect(response.status).to eq(200)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/subjects/1")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/subjects" do
    it "creates new subject", autodoc: true do
      admin = create_admin_with_token
      old_size = Subject.count
      post_with_token(admin, "/api/subjects", { title_ja: "生理学", title_en: "physiology" }.to_json)
      expect(response.status).to eq(201)
      expect(Subject.count).to eq(old_size + 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      post_with_token(guest, "/api/subjects", { title_ja: "生理学Ⅰ", title_en: "physiology_1" }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      post("/api/subjects", { title_ja: "生理学Ⅰ", title_en: "physiology_1" }.to_json)
      expect(response.status).to eq(401)
    end
  end

  describe "PATCH /api/subjects/1" do
    before do
      create(:subject)
    end

    it "updates subject", autodoc: true do
      admin = create_admin_with_token
      patch_with_token(admin, "/api/subjects/1", { title_ja: "生化学Ⅰ", title_en: "biochemistry_1" }.to_json)
      expect(response.status).to eq(200)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/subjects/1", { title_ja: "生化学Ⅰ", title_en: "biochemistry_1" }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/subjects/1", { title_ja: "生化学Ⅰ", title_en: "biochemistry_1" }.to_json)
      expect(response.status).to eq(401)
    end
  end

  describe "DELETE /api/subjects/1" do
    before do
      create(:subject)
    end

    it "destroys specified record", autodoc: true do
      admin = create_admin_with_token
      old_size = Subject.count
      delete_with_token(admin, "/api/subjects/1")
      expect(response.status).to eq(200)
      expect(Subject.count).to eq(old_size - 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      delete_with_token(guest, "/api/subjects/1")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      delete("/api/subjects/1")
      expect(response.status).to eq(401)
    end
  end
end
