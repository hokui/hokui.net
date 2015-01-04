require 'rails_helper'

RSpec.describe "News", :type => :request do
  before(:all) do
    20.times { create(:news) }
  end

  describe "GET /api/news" do
    it "returns a list of news", autodoc: true do
      size = News.count
      last_text = News.last.text
      guest = create_guest_with_token
      get_with_token(guest, "/api/news")
      expect(response.status).to eq(200)
      expect(json[0]["text"]).to eq(last_text)
      expect(json.length).to eq(size)
    end

    it "returns specified number of latest news" do
      last_text = News.last.text
      guest = create_guest_with_token
      get_with_token(guest, "/api/news?count=5")
      expect(response.status).to eq(200)
      expect(json[0]["text"]).to eq(last_text)
      expect(json.length).to eq(5)
    end

    it "returns 401 to an unauthorized client" do
      get("/api/news")
      expect(response.status).to eq(401)
    end
  end

  describe "GET /api/news/1" do
    it "returns news", autodoc: true do
      id = News.first.id
      guest = create_guest_with_token
      get_with_token(guest, "/api/news/#{id}")
      expect(response.status).to eq(200)
      expect(json["text"]).to match(/news/)
    end

    it "returns 401 to an unauthorized client" do
      id = News.first.id
      get("/api/news/#{id}")
      expect(response.status).to eq(401)
    end
  end

  describe "POST /api/news" do
    it "creates new news", autodoc: true do
      admin = create_admin_with_token
      old_size = News.count
      post_with_token(admin, "/api/news", { text: "hoge" }.to_json)
      expect(response.status).to eq(201)
      expect(json["text"]).to eq("hoge")
      expect(News.count).to eq(old_size + 1)
    end

    it "returns 403 to a guest" do
      guest = create_guest_with_token
      post_with_token(guest, "/api/news", { text: "hoge" }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      post("/api/news", { test: "hoge" }.to_json)
      expect(response.status).to eq(401)
    end

    it "returns 422 when model validation fails" do
      admin = create_admin_with_token
      post_with_token(admin, "/api/news", {}.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["text"]).to include("can't be blank")
    end
  end

  describe "PATCH /api/news/1" do
    it "updates news", autodoc: true do
      id = News.first.id
      admin = create_admin_with_token
      patch_with_token(admin, "/api/news/#{id}", { text: "hoge" }.to_json)
      expect(response.status).to eq(200)
      expect(json["text"]).to eq("hoge")
    end

    it "returns 403 to a guest" do
      id = News.first.id
      guest = create_guest_with_token
      patch_with_token(guest, "/api/news/#{id}", { text: "hoge" }.to_json)
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      id = News.first.id
      patch("/api/news/#{id}", { text: "hoge" }.to_json)
      expect(response.status).to eq(401)
    end

    it "returns 422 when model validation fails" do
      id = News.first.id
      admin = create_admin_with_token
      patch_with_token(admin, "/api/news/#{id}", { text: "" }.to_json)
      expect(response.status).to eq(422)
      expect(json["errors"]["text"]).to include("can't be blank")
    end
  end

  describe "DELETE /api/news/1" do
    it "destroys specified record", autodoc: true do
      id = News.first.id
      admin = create_admin_with_token
      old_size = News.count
      delete_with_token(admin, "/api/news/#{id}")
      expect(response.status).to eq(200)
      expect(News.count).to eq(old_size - 1)
    end

    it "returns 403 to a guest" do
      id = News.first.id
      guest = create_guest_with_token
      delete_with_token(guest, "/api/news/#{id}")
      expect(response.status).to eq(403)
    end

    it "returns 401 to an unauthorized client" do
      id = News.first.id
      delete("/api/news/#{id}")
      expect(response.status).to eq(401)
    end
  end
end
