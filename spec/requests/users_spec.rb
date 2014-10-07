require 'rails_helper'

RSpec.describe "Users" do
  describe "GET /api/users" do
    it "returns a list of users to an admin", autodoc: true do
      admin = create_admin_with_token
      get_with_token(admin, "/api/users")
      expect(response.status).to eq(200)
    end

    it "returns 403 to a guest", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/users")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/users")
      expect(response.status).to eq(401)
    end
  end

  describe "GET /api/users/1" do
    it "returns user profile to an admin", autodoc: true do
      admin = create_admin_with_token
      guest = create_guest_with_token
      get_with_token(admin, "api/users/#{guest.id}")
      expect(response.status).to eq(200)
    end

    it "returns user profile to a guest if the client requests profile of oneself", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "api/users/#{guest.id}")
      expect(response.status).to eq(200)
    end

    it "returns 403 to a guest if the client requests profile of another user", autodoc: true do
      admin = create_admin_with_token
      guest = create_guest_with_token
      get_with_token(guest, "api/users/#{admin.id}")
    end

    it "returns 401 to an unauthorized client" do
      get("/api/users/1")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/users" do
    before do
      create(:class_year)
      @params = FactoryGirl.attributes_for(:guest)
      @params[:class_year] = 93
      @params.delete(:class_year_id)
      @params.delete(:admin)
    end

    it "creates new user", autodoc: true do
      old_size = User.count
      post("/api/users", @params.to_json)
      expect(response.status).to eq(201)
      expect(User.count).to eq(old_size + 1)
    end

    it "does not create new user if params are invalid" do
      @params[:password] = nil
      old_size = User.count
      post("/api/users", @params.to_json)
      expect(response.status).to eq(422)
      expect(User.count).to eq(old_size)
    end
  end

  describe "GET /api/users/profile" do
    it "returns self profile to an user", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/users/profile")
      expect(response.status).to eq(200)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/users/profile")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/users/activate" do
    before do
      @guest = create(:guest)
      @params = { email_local: @guest.email_local, activation_token: @guest.activation_token }
    end

    it "successes if the guest is previously unactivated", autodoc: true do
      post("/api/users/activate", @params.to_json)
      expect(response.status).to eq(200)
    end

    it "fails if the guest is already activated", autodoc: true do
      @guest.activate!
      post("/api/users/activate", @params.to_json)
      expect(response.status).to eq(400)
    end
  end

  describe "POST /api/users/1/approve" do
    before do
      @admin = create_admin_with_token
      @guest = create_guest_with_token
    end

    it "successes when an admin approves a guest", autodoc: true do
      post_with_token(@admin, "/api/users/#{@guest.id}/approve")
      expect(response.status).to eq(200)
    end

    it "returns 403 to a guest", autodoc: true do
      post_with_token(@guest, "/api/users/#{@guest.id}/approve")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      post("/api/users/1/approve")
      expect(response.status).to eq(401)
    end
  end

  describe "DELETE /api/users/1" do
    it "successes", autodoc: true do
      admin = create_admin_with_token
      guest = create(:guest)
      delete_with_token(admin, "/api/users/#{guest.id}")
      expect(response.status).to eq(200)
    end

    it "returns 403 to a guest", autodoc: true do
      guest = create_guest_with_token
      admin = create(:admin)
      delete_with_token(guest, "/api/users/#{admin.id}")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      guest = create(:guest)
      delete("/api/users/#{guest.id}")
      expect(response.status).to eq(401)
    end
  end
end
