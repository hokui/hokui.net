require 'rails_helper'

RSpec.describe "Semesters", :type => :request do
  before(:all) do
    create(:class_year)
    3.times { create(:subject) }
    s = create(:semester)
    s.subject_ids = [1, 2]
    s.save!
  end

  describe "GET /api/semesters" do
    it "returns a list of semesters", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/semesters")
      expect(response.status).to eq(200)
      expect(json[0]["identifier"]).to eq("2a")
      expect(json[0]["subject_ids"]).to eq([1, 2])
    end

    it "returns 401 to an unauthorized client" do
      get("/api/semesters")
      expect(response.status).to eq(401)
    end
  end

  describe "GET /api/semesters/1" do
    it "returns semester", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/semesters/1")
      expect(response.status).to eq(200)
      expect(json["identifier"]).to eq("2a")
      expect(json["subject_ids"]).to eq([1, 2])
    end

    it "returns 401 to an unauthorized client" do
      get("/api/semesters/1")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/semesters" do
    it "creates new semester", autodoc: true do
      admin = create_admin_with_token
      old_size = Semester.count
      post_with_token(admin, "/api/semesters", { class_year_id: 1, identifier: "2b", subject_ids: [1, 2] }.to_json)
      expect(response.status).to eq(201)
      expect(json["identifier"]).to eq("2b")
      expect(json["subject_ids"]).to eq([1, 2])
      expect(Semester.count).to eq(old_size + 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      post_with_token(guest, "/api/semesters", { class_year_id: 1, identifier: "2b", subject_ids: [1, 2] }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      post("/api/semesters", { class_year_id: 1, identifier: "2b", subject_ids: [1, 2] }.to_json)
      expect(response.status).to eq(401)
    end

    it "returns 422 when model validation fails" do
      admin = create_admin_with_token
      post_with_token(admin, "/api/semesters", {}.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["identifier"]).to include("入力してください。")
    end
  end

  describe "PATCH /api/semesters/1" do
    it "updates semester", autodoc: true do
      admin = create_admin_with_token
      patch_with_token(admin, "/api/semesters/1", { class_year_id: 1, identifier: "3a", subject_ids: [2, 3] }.to_json)
      expect(response.status).to eq(200)
      expect(json["identifier"]).to eq("3a")
      expect(json["subject_ids"]).to eq([2, 3])
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/semesters/1", { class_year_id: 1, identifier: "3a", subject_ids: [2, 3] }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/semesters/1", { class_year_id: 1, identifier: "3a", subject_ids: [2, 3] }.to_json)
      expect(response.status).to eq(401)
    end

    it "returns 422 when model validation fails" do
      s = Semester.create!(class_year_id: 1, identifier: "2b")

      admin = create_admin_with_token
      patch_with_token(admin, "/api/semesters/#{s.id}", { identifier: "2a" }.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["identifier"]).to include("すでに使われています。")
    end
  end

  describe "DELETE /api/semesters/1" do
    it "destroys specified record", autodoc: true do
      admin = create_admin_with_token
      old_size = Semester.count
      delete_with_token(admin, "/api/semesters/1")
      expect(response.status).to eq(200)
      expect(Semester.count).to eq(old_size - 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      delete_with_token(guest, "/api/semesters/1")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      delete("/api/semesters/1")
      expect(response.status).to eq(401)
    end
  end
end
