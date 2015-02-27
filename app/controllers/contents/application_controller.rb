class Contents::ApplicationController < ActionController::Base
  def not_found
    head 404
  end
end
