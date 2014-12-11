require 'rails_helper'

RSpec.describe "PasswordResets", :type => :request do
  describe "POST /api/password_reset" do
    before do
      @guest = create(:guest)
    end

    it "delivers reset password instruction" do
      expect_any_instance_of(User).to receive(:generate_reset_password_token!)
      expect_any_instance_of(User).to receive(:send_reset_password_instructions!)
      post("/api/password_reset", { email: @guest.email }.to_json)
      expect(response.status).to eq(200)
    end

    it "returns 404 if email is not found" do
      expect_any_instance_of(User).not_to receive(:generate_reset_password_token!)
      expect_any_instance_of(User).not_to receive(:send_reset_password_instructions!)
      post("/api/password_reset", { email: "hoge@fuga.net" }.to_json)
      expect(response.status).to eq(404)
    end
  end

  describe "PATCH /api/password_reset" do
    before do
      @guest = create(:guest)
      @guest.generate_reset_password_token!
    end

    it "changes user's password" do
      patch("/api/password_reset", { reset_password_token: @guest.reset_password_token, new_password: "abcde" }.to_json)
      expect(response.status).to eq(200)
      expect(User.authenticate(@guest.email, "abcde")).to eq(@guest)
    end

    it "returns 404 if token is not found" do
      expect_any_instance_of(User).not_to receive(:change_password!)
      patch("/api/password_reset", { reset_password_token: "hogefuga", new_password: "abcde" }.to_json)
      expect(response.status).to eq(404)
    end
  end
end
