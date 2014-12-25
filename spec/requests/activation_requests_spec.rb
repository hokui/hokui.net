require 'rails_helper'

RSpec.describe "ActivationRequests", type: :request do
  describe "POST /api/activation_request" do
    before do
      @guest = create(:guest, activate: false, approve: false)
    end

    it "delivers activation instruction", autodoc: true do
      expect_any_instance_of(User).to receive(:send_activation_needed_email!)
      post("/api/activation_request", { email: @guest.email }.to_json)
      expect(response.status).to eq(200)
    end

    it "returns 404 if user is not found on db", autodoc: true do
      expect_any_instance_of(User).not_to receive(:send_activation_needed_email!)
      post("/api/activation_request", { email: "hoge@ec.hokudai.ac.jp" }.to_json)
      expect(response.status).to eq(404)
    end
  end
end
