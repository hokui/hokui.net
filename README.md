hokui.net
=========

開発環境
--------
最初だけ
```
bundle install --path .bundle/gems --jobs=4

# install mailcatcher gem
gem install mailcatcher
# boot mailcatcher server, then goto localhost:1080
mailcatcher
```

`git pull upstream master`した後毎回  
Gemを更新してDBをリセット
```
bundle install
bundle exec rake db:dev
```
