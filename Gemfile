source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '4.2.0.rc1'
gem 'rails-api'
gem 'sqlite3'

gem 'active_model_serializers', '~>0.8.0'

gem 'thin'

gem 'whenever', require: false

gem 'sorcery', github: 'iTakeshi/sorcery', branch: 'user_approval'
gem 'pundit'

gem 'kawaii_validation'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller'

  gem 'annotate'
  gem 'bullet'
  gem 'hirb'
  gem 'hirb-unicode'

  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
end

group :development, :test do
  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_rewinder'
  gem 'autodoc', github: 'iTakeshi/autodoc'
  gem 'codeclimate-test-reporter', require: nil
end
