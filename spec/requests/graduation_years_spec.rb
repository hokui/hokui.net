require 'rails_helper'

RSpec.describe "GraduationYears", :type => :request do
  describe "GET /api/graduation_years" do
    it "returns a list of graduation years", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/graduation_years")
      expect(response.status).to eq(200)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/graduation_years")
      expect(response.status).to eq(401)
    end
  end

  describe "GET /api/graduation_years/1" do
    before do
      create(:graduation_year)
    end

    it "returns graduation year", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/graduation_years/1")
      expect(response.status).to eq(200)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/graduation_years/1")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/graduation_years" do
    it "creates new graduation year", autodoc: true do
      admin = create_admin_with_token
      old_size = GraduationYear.count
      post_with_token(admin, "/api/graduation_years", { graduation_year: { year: 2017 } }.to_json)
      expect(response.status).to eq(201)
      expect(GraduationYear.count).to eq(old_size + 1)
    end

    it "creates new graduation year if a class year is passed", autodoc: true do
      admin = create_admin_with_token
      old_size = GraduationYear.count
      post_with_token(admin, "/api/graduation_years", { graduation_year: { year: 93 } }.to_json)
      expect(response.status).to eq(201)
      expect(GraduationYear.count).to eq(old_size + 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      post_with_token(guest, "/api/graduation_years", { graduation_year: { year: 2017 } }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      post("/api/graduation_years", { graduation_year: { year: 2017 } }.to_json)
      expect(response.status).to eq(401)
    end
  end

  describe "PATCH /api/graduation_years/1" do
    before do
      create(:graduation_year)
    end

    it "updates graduation year", autodoc: true do
      admin = create_admin_with_token
      patch_with_token(admin, "/api/graduation_years/1", { graduation_year: { year: 2018 } }.to_json)
      expect(response.status).to eq(200)
    end

    it "updates graduation year if a class year is passed", autodoc: true do
      admin = create_admin_with_token
      patch_with_token(admin, "/api/graduation_years/1", { graduation_year: { year: 94 } }.to_json)
      expect(response.status).to eq(200)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/graduation_years/1", { graduation_year: { year: 2017 } }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/graduation_years/1", { graduation_year: { year: 2017 } }.to_json)
      expect(response.status).to eq(401)
    end
  end

  describe "DELETE /api/graduation_years/1" do
    before do
      create(:graduation_year)
    end

    it "destroys specified record", autodoc: true do
      admin = create_admin_with_token
      old_size = GraduationYear.count
      delete_with_token(admin, "/api/graduation_years/1")
      expect(response.status).to eq(200)
      expect(GraduationYear.count).to eq(old_size - 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      delete_with_token(guest, "/api/graduation_years/1")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      delete("/api/graduation_years/1")
      expect(response.status).to eq(401)
    end
  end
end
