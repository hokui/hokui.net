class ApplicationController < ActionController::API
  def index
    render file: "public/index.html"
  end
end
