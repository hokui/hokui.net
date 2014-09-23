hokui.net
=========
[![Build Status](https://travis-ci.org/hokui/hokui.net.svg)](https://travis-ci.org/hokui/hokui.net)
[![Code Climate](https://codeclimate.com/github/hokui/hokui.net/badges/gpa.svg)](https://codeclimate.com/github/hokui/hokui.net)
[![Test Coverage](https://codeclimate.com/github/hokui/hokui.net/badges/coverage.svg)](https://codeclimate.com/github/hokui/hokui.net)

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

フロントのビルド
--------
```
npm start
```
