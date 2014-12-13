require 'rails_helper'

RSpec.describe "Passwords", :type => :request do
  describe "GET /api/profile/password" do
    it "updates password", autodoc: true do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/profile/password", { password: "hogefuga" }.to_json)
      expect(response.status).to eq(200)
    end

    it "returns 422 if new password is blank" do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/profile/password", { password: "" }.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["password"]).to include("can't be blank")
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/profile/password", { password: "hogefuga" }.to_json)
      expect(response.status).to eq(401)
    end
  end
end
