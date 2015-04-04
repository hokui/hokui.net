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

    it "returns 400 if user is not found on db", autodoc: true do
      expect_any_instance_of(User).not_to receive(:send_activation_needed_email!)
      post("/api/activation_request", { email: "hoge@eis.hokudai.ac.jp" }.to_json)
      expect(response.status).to eq(400)
      expect(json).to eq({})
    end

    it "returns 400 if user is already activated", autodoc: true do
      @guest.activate!
      expect_any_instance_of(User).not_to receive(:send_activation_needed_email!)
      post("/api/activation_request", { email: @guest.email }.to_json)
      expect(response.status).to eq(400)
      expect(json).to eq({ "approval_state" => "waiting" })
    end

    it "returns 400 if user is already activated and approved", autodoc: true do
      @guest.activate!
      @guest.approve!
      expect_any_instance_of(User).not_to receive(:send_activation_needed_email!)
      post("/api/activation_request", { email: @guest.email }.to_json)
      expect(response.status).to eq(400)
      expect(json).to eq({ "approval_state" => "approved" })
    end
  end
end
