require 'rails_helper'

RSpec.describe 'Application', :type => :request do
  before(:each) do
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
end
