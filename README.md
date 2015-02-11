hokui.net
=========
**Project**  
[![Build Status](https://travis-ci.org/hokui/hokui.net.svg)](https://travis-ci.org/hokui/hokui.net)  
**Backend**  
[![Code Climate](https://codeclimate.com/github/hokui/hokui.net/badges/gpa.svg)](https://codeclimate.com/github/hokui/hokui.net)
[![Test Coverage](https://codeclimate.com/github/hokui/hokui.net/badges/coverage.svg)](https://codeclimate.com/github/hokui/hokui.net)  
**Frontend**  
[![Coverage Status](https://coveralls.io/repos/hokui/hokui.net/badge.svg?branch=)](https://coveralls.io/r/hokui/hokui.net?branch=)
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
**NOTE**: Need to install `Gulp` globally or run Gulp with `npm run gulp ...`.

### 開発版ビルド
`public/`に、`client/`以降の構造をほぼ保ったまま展開する。
`client/config/development/development.coffee`がビルドに含まれ、`client/config/production/production.coffee`はスルーされる。

### プロダクションビルド
`dist/`に展開。`index.jade`以外のマークアップはすべてテンプレートとして`$templateChache`を使ってスクリプトに埋め込み、他のスクリプトも合わせて結合/Minifyして一つのファイルで出力。スタイルシートも同様にして一つのファイルで出力。  
開発版と逆で、`client/config/production/production.coffee`がビルドに含まれ、`client/config/development/development.coffee`はスルーされる。

### Gulpのビルドについて

- `gulp` ... 開発版ビルドを行ったのちライブリロードが有効な状態で開発サーバー(http://localhost:9000)が立ち上がる
- `gulp silent serve` ... 上のうるさくない版
- `gulp prod [skipmin, slient] build` ... プロダクションビルドのみ。`skipmin`でMinify省略。`silent`を付けるとビルドに失敗してもうるさくない
- `gulp prod [skipmin, silent] serve` ... プロダクションビルドして`dist/`で開発サーバー起動(ラライブリロードなし)

### 一発構築
```
npm start
```
`npm install`と`bower install`と`gulp silent serve`が走る。フロントのコミット後は何も考えずこれでOK。

### test
```
npm test
```
現状`client/core/`以下のKarmaを使ったユニットテストのみ。


Run hokui.net on Nginx
--------
1. Place the project or its symbolic link to `/var/www/hokui.net`
2. Boot Rails Server: `bundle exec rails s -e production`
3. Build client codes: `gulp prod build`
4. Then, boot Nginx: `sudo nginx -c /var/www/hokui.net/nginx/nginx.conf` or `npm run nginx`


