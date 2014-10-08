require 'rails_helper'

RSpec.describe "Sessions" do
  describe "POST /api/session" do
    before do
      @guest = create(:guest)
      @guest.activate!
      @guest.approve!
    end

    it "returns new access token and user profile", autodoc: true do
      email = "guest@ec.hokudai.ac.jp"
      password = "guest"
      params = { email: email, password: password }

      old_size = AccessToken.count

      post("/api/session", params.to_json)
      expect(response.status).to eq(201)
      expect(json["token"].class).to eq(String)
      expect(json["token"].length).to be > 10
      expect(json["user"]["full_name"]).to eq("guest guest")
      expect(json["user"]["crypted_password"]).to be_nil
      expect(AccessToken.count).to eq(old_size + 1)
    end

    it "returns 422 if password is wrong", autodoc: true do
      email = "guest@ec.hokudai.ac.jp"
      password = "admin"
      params = { email: email, password: password }

      old_size = AccessToken.count

      post("/api/session", params.to_json)
      expect(response.status).to eq(422)
      expect(AccessToken.count).to eq(old_size)
    end
  end

  describe "DELETE /api/session" do
    it "destroys existing access token", autodoc: true do
      guest = create_guest_with_token

      old_size = AccessToken.count

      delete_with_token(guest, "/api/session")
      expect(response.status).to eq(200)
      expect(AccessToken.count).to eq(old_size - 1)
    end

    it "returns 200 if ever unexisting token is passed" do
      access_token = build(:access_token)

      old_size = AccessToken.count

      delete("/api/session", nil, { "Access-Token" => access_token.token })
      expect(response.status).to eq(200)
      expect(AccessToken.count).to eq(old_size)
    end
  end
end

