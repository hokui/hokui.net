source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

gem 'rails', '4.2.0'
gem 'rails-api', github: 'iTakeshi/rails-api', branch: 'rails42'
gem 'sqlite3'

gem 'active_model_serializers', github: 'rails-api/active_model_serializers'

gem 'thin'

gem 'whenever', require: false

gem 'sorcery', github: 'iTakeshi/sorcery', branch: 'user_approval'
gem 'pundit'

gem 'kawaii_validation'

group :development, :test do
  gem 'annotate'
  gem 'bullet'
  gem 'hirb'
  gem 'hirb-unicode'

  gem 'pry-rails'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'

  gem 'rspec-rails'
  gem 'factory_girl_rails'
  gem 'database_rewinder'
  gem 'autodoc'
  gem 'codeclimate-test-reporter', require: nil
end
