require "codeclimate-test-reporter"
CodeClimate::TestReporter.start

ENV["RAILS_ENV"] ||= 'test'
require 'spec_helper'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'factory_girl'
require File.expand_path("../helpers", __FILE__)

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.include Helpers

  config.infer_spec_type_from_file_location!

  config.use_transactional_fixtures = true
  config.include FactoryGirl::Syntax::Methods
  config.before :suite do
    DatabaseRewinder.clean_all
    FactoryGirl.lint
  end
  config.before :all do
    DatabaseRewinder.clean_all
    FactoryGirl.reload
  end
  config.after :each do
    DatabaseRewinder.clean
  end
end

Autodoc.configuration.suppressed_request_header =
  ["Accept", "Content-Length", "Content-Type", "Host"]
Autodoc.configuration.suppressed_response_header =
  ["Cache-Control", "Content-Length", "ETag", "X-Content-Type-Options",
   "X-Frame-Options", "X-Request-Id", "X-Runtime", "X-XSS-Protection"]
Autodoc.configuration.template =
  File.read(File.expand_path("../autodoc/templates/document.md.erb", __FILE__))
