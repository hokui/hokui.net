cp config/application.yml.ci config/application.yml
bash scripts/setup_mailing_list_server.sh
export CODECLIMATE_REPO_TOKEN=6379678c9245d7c0695b4a011bac7e58e9a59ee91e5486af9e3ce494d3d7f9f8
rvm use 2.2.0 --install
bundle install --jobs=4
export RAILS_ENV=test
bundle exec rake db:migrate
bundle exec rake db:seed
nvm install 0.10.25
nvm use 0.10.25
npm install
