cd ~
git clone https://github.com/hokui/mailing_list.git
cd mailing_list
bundle --jobs=4
bundle exec rake db:migrate
bundle exec rails server -p 3001 &
