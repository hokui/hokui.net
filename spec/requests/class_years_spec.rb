require 'rails_helper'

RSpec.describe "ClassYears", :type => :request do
  describe "GET /api/class_years" do
    before do
      create(:class_year)
    end

    it "returns a list of class years, if ever client is unauthorized", autodoc: true do
      get("/api/class_years")
      expect(response.status).to eq(200)
      expect(json[0]["year"]).to eq(93)
    end
  end

  describe "GET /api/class_years/1" do
    before do
      create(:class_year)
    end

    it "returns class year", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/class_years/1")
      expect(response.status).to eq(200)
      expect(json["year"]).to eq(93)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/class_years/1")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/class_years" do
    it "creates new class year", autodoc: true do
      admin = create_admin_with_token
      old_size = ClassYear.count
      post_with_token(admin, "/api/class_years", { year: 93 }.to_json)
      expect(response.status).to eq(201)
      expect(json["year"]).to eq(93)
      expect(ClassYear.count).to eq(old_size + 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      post_with_token(guest, "/api/class_years", { year: 93 }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      post("/api/class_years", { year: 93 }.to_json)
      expect(response.status).to eq(401)
    end
  end

  describe "PATCH /api/class_years/1" do
    before do
      create(:class_year)
    end

    it "updates class year", autodoc: true do
      admin = create_admin_with_token
      patch_with_token(admin, "/api/class_years/1", { year: 94 }.to_json)
      expect(response.status).to eq(200)
      expect(json["year"]).to eq(94)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/class_years/1", { year: 94 }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/class_years/1", { year: 94 }.to_json)
      expect(response.status).to eq(401)
    end
  end

  describe "DELETE /api/class_years/1" do
    before do
      create(:class_year)
    end

    it "destroys specified record", autodoc: true do
      admin = create_admin_with_token
      old_size = ClassYear.count
      delete_with_token(admin, "/api/class_years/1")
      expect(response.status).to eq(200)
      expect(ClassYear.count).to eq(old_size - 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      delete_with_token(guest, "/api/class_years/1")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      delete("/api/class_years/1")
      expect(response.status).to eq(401)
    end
  end
end
