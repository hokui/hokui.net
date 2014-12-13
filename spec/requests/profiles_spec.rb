require 'rails_helper'

RSpec.describe "Profiles", :type => :request do
  describe "GET /api/profile" do
    it "returns self profile to an user", autodoc: true do
      guest = create_guest_with_token
      get_with_token(guest, "/api/profile")
      expect(response.status).to eq(200)
      expect(json["full_name"]).to eq("guest guest")
      expect(json["crypted_password"]).to be_nil
    end

    it "returns 401 to an unauthorized client" do
      get("/api/profile")
      expect(response.status).to eq(401)
    end
  end
end
