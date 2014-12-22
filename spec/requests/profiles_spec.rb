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

  describe "PATCH /api/profile" do
    before do
      @params = {
        handle_name: "hoge",
        email_mobile: "hoge@example.com",
        class_year_id: 2
      }
    end

    it "updates profile", autodoc: true do
      guest = create_guest_with_token
      patch_with_token(guest, "/api/profile", @params.to_json)
      expect(response.status).to eq(200)
      expect(json["handle_name"]).to eq("hoge")
      expect(json["class_year_id"]).to eq(2)
    end

    it "returns 422 to a request with invalid params" do
      create(:admin)
      guest = create_guest_with_token
      @params[:handle_name] = "admin"
      patch_with_token(guest, "/api/profile", @params.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["handle_name"]).to include("はすでに存在します。")
    end

    it "returns 401 to an unauthorized client" do
      patch("/api/profile", @params.to_json)
      expect(response.status).to eq(401)
    end
  end
end
