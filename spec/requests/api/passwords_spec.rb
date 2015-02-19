require 'rails_helper'

RSpec.describe "Passwords", type: :request do
  describe "GET /api/profile/password" do
    it "updates password", autodoc: true do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/profile/password", { current_password: "guest", password: "hogefuga" }.to_json)
      expect(response.status).to eq(200)
      expect(User.authenticate(guest.email, "hogefuga")).to eq(guest)
    end

    it "returns 401 if current password is wrong" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/profile/password", { current_password: "admin", password: "hogefuga" }.to_json)
      expect(response.status).to eq(401)
      expect(json["errors"]["current_password"]).to include("is wrong")
      expect(User.authenticate(guest.email, "")).to be_nil
    end

    it "returns 422 if new password is blank" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/profile/password", { current_password: "guest", password: "" }.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["password"]).to include("can't be blank")
      expect(User.authenticate(guest.email, "")).to be_nil
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/profile/password", { current_password: "guest", password: "hogefuga" }.to_json)
      expect(response.status).to eq(401)
    end
  end
end
