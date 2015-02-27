require 'rails_helper'

RSpec.describe 'Application', type: :request do
  it "returns 404 to a request for nonexistent url" do
    get("/contents/hogefuga")
    expect(response.status).to eq(404)
  end
end
