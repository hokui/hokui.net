require 'rails_helper'

RSpec.describe 'Application', :type => :request do
  before(:each) do
    @admin = create_admin_with_token
    @guest = create_guest_with_token
  end

  it "returns 401 when the client is inactivated" do
    @guest.activation_state = "pending"
    @guest.save
    get_with_token(@guest, "api/users/#{@guest.id}")
    expect(response.status).to eq(401)
  end

  it "returns 401 when the client is unapproved" do
    @guest.approval_state = "waiting"
    @guest.save
    get_with_token(@guest, "api/users/#{@guest.id}")
    expect(response.status).to eq(401)
  end

  it "returns 400 to a request with malformed json" do
    raw_post_with_token(@admin, "/api/class_years", "{\"year\":94")
    expect(response.status).to eq(400)
  end

  it "returns 404 to a request for nonexistent url, even if the client is unauthenticated" do
    get("/api/hogefuga")
    expect(response.status).to eq(404)
  end
end
