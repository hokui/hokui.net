cp config/application.yml.ci config/application.yml
bash scripts/setup_mailing_list_server.sh
export CODECLIMATE_REPO_TOKEN=6379678c9245d7c0695b4a011bac7e58e9a59ee91e5486af9e3ce494d3d7f9f8
export SAUCE_USERNAME=endaaman
export SAUCE_ACCESS_KEY=b71f108fc073-ae18-c904-5f8f-08589d51
export LOGS_DIR=/tmp/hokui.net-build/logs
export BROWSER_PROVIDER_READY_FILE=/tmp/sauce-connect-ready
rvm use 2.2.0 --install
bundle install --jobs=4
export RAILS_ENV=test
bundle exec rake db:migrate
bundle exec rake db:seed
nvm install 0.10.25
nvm use 0.10.25
npm install
npm install -g bower
bower install
node_modules/protractor/bin/webdriver-manager update
mkdir -p $LOGS_DIR
bash scripts/sauce_connect_setup.sh
bash scripts/wait_for_browser_provider.sh
