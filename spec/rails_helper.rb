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
  config.before :all do
    FactoryGirl.reload
  end
  config.before :suite do
    DatabaseRewinder.clean_all
    FactoryGirl.lint
  end
  config.before :each do
    DatabaseRewinder.clean
  end
end
