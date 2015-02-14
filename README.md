hokui.net
=========
**Project**  
[![Build Status](https://travis-ci.org/hokui/hokui.net.svg)](https://travis-ci.org/hokui/hokui.net)  
**Backend**  
[![Code Climate](https://codeclimate.com/github/hokui/hokui.net/badges/gpa.svg)](https://codeclimate.com/github/hokui/hokui.net)
[![Test Coverage](https://codeclimate.com/github/hokui/hokui.net/badges/coverage.svg)](https://codeclimate.com/github/hokui/hokui.net)  
**Frontend**  
[![Coverage Status](https://coveralls.io/repos/hokui/hokui.net/badge.svg?branch=master)](https://coveralls.io/r/hokui/hokui.net?branch=master)

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

**NOTE**: Need to install `Gulp` globally or run `Gulp` with `npm run gulp ...`.

### 開発版ビルド
`public/`に、`client/`以降の構造を保って展開する。


### プロダクションビルド
`dist/`に展開する。
`index.jade`以外のマークアップはすべてテンプレートとして`$templateChache`を使ってJSに埋め込み、他と併せて結合/圧縮して一つのファイルで出力。CSSも同様。


### Gulp

#### タスク

* `gulp` ... 開発版ビルドを行い、バックエンドで`Rails`サーバーを起動し、開発サーバー(`http://localhost:9000`)が立ち上げる
* `gulp serve` ... 上記の`Rails`サーバーを起動しない版
* `gulp build` ... ビルドのみ。
* `gulp e2e` ... `http://localhost:9000`に対してE2Eテストを実行する
* `gulp run-e2e` ... ビルド、`Rails`サーバー/開発サーバーの起動、DB初期化後、E2Eテストを実行する
* `gulp rails` ... バックエンドで`Rails`サーバー起動
* `gulp rails:stop` ... バックエンドで起動した`Rails`サーバーを停止
* `gulp rails:setup` ... `bundle exec rake db:dev`のエイリアス


#### オプション

* `--prod` ... プロダクションビルドになる。開発サーバーを立ち上げる場合はライブリロードは無効化
* `--nosound` ... エラーを起こしてもうるさくない
* `--skipmin` ... プロダクションビルドでJSとCSSの圧縮をしない(結合のみ)
* `--seed` ... ログインとユーザー登録のときに初期値を入力した状態になる


### ユニットテスト
* `npm test` ... 対象は`client/core/**/*.coffee`のみ


### 一発構築

```
npm start
```

`npm install && bower install && gulp --seed --nosound`が実行される。


Run hokui.net on Nginx
--------
1. Place the project or its symbolic link to `/var/www/hokui.net`
2. Boot Rails Server: `bundle exec rails s -e production`
3. Build client codes: `gulp prod build`
4. Then, boot Nginx: `sudo nginx -c /var/www/hokui.net/nginx/nginx.conf` or `npm run nginx`


