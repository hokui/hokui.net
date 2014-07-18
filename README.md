hokui.net
=========

開発環境
--------
```
bundle install --path .bundle/gems --jobs=4
bundle exec rake db:migrate
bundle exec rake db:seed:development

# install mailcatcher gem
gem install mailcatcher
# boot mailcatcher server, then goto localhost:1080
mailcatcher
```
