hokui.net
=========
[![Build Status](https://travis-ci.org/hokui/hokui.net.svg)](https://travis-ci.org/hokui/hokui.net)
[![Code Climate](https://codeclimate.com/github/hokui/hokui.net/badges/gpa.svg)](https://codeclimate.com/github/hokui/hokui.net)
[![Test Coverage](https://codeclimate.com/github/hokui/hokui.net/badges/coverage.svg)](https://codeclimate.com/github/hokui/hokui.net)

バックエンド
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

フロントエンド
--------
### ビルド
**NOTE**: Need to install `Gulp` globally or run Gulp with `npm run gulp ...`.

#### development, watchなし
```
gulp build
```

#### development, watchあり
```
gulp
```
だけ

#### production
```
gulp prod build
```

#### production, skip minify
```
gulp prod skipmin build
```
minifyは時間かかるので飛ばしたいとき

### 一発構築
```
npm start
```
`npm install`と`bower install`と`gulp build`が走る。フロントのコミット後は何も考えずこれでOK。

### test
```
npm test
```

Run hokui.net on nginx
--------
1. Place the project or its symbolic link to `/var/www/hokui.net`
2. Boot Rails Server: `bundle exec rails s -e production`
3. Build client codes: `gulp prod build`
4. Then, boot Nginx: `sudo nginx -c /var/www/hokui.net/nginx/nginx.conf`


