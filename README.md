# hokui.net

**Project**  
[![Codeship Status for hokui/hokui.net](https://codeship.com/projects/1b154840-a7bd-0132-be13-5ac1da2e580b/status?branch=master)](https://codeship.com/projects/67249)  
**Backend**  
[![Code Climate](https://codeclimate.com/github/hokui/hokui.net/badges/gpa.svg)](https://codeclimate.com/github/hokui/hokui.net)
[![Test Coverage](https://codeclimate.com/github/hokui/hokui.net/badges/coverage.svg)](https://codeclimate.com/github/hokui/hokui.net)  
**Frontend**  
[![Coverage Status](https://coveralls.io/repos/hokui/hokui.net/badge.svg?branch=master)](https://coveralls.io/r/hokui/hokui.net?branch=master)

## バックエンド

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

## フロントエンド

**NOTE**: Need to install `Gulp` globally or run `Gulp` with `npm run gulp ...`.

### 開発版ビルド
`public/`に、`client/`以降の構造を保って展開する。


### プロダクションビルド
`dist/`に展開する。
`index.jade`以外のマークアップはすべてテンプレートとして`$templateChache`を使ってJSに埋め込み、他と併せて結合/圧縮して一つのファイルで出力。CSSも同様。

### 開発サーバーについて
Nginxとの歳


### Gulp

**タスク**

* `gulp` ... ビルドして、バックエンドで`Rails`サーバー(daemonized)と、開発サーバー(`http://localhost:9000`)を起動し、ファイルの監視/Livereloadをする
* `gulp watch` ... 上記の`Rails`サーバーを起動しない版
* `gulp serve` ... 上記さらにファイル監視を行わない版
* `gulp build` ... ビルドのみ
* `gulp e2e` ... `http://localhost:9000`に対してE2Eテストを実行する
* `gulp run-e2e` ... ビルド、DB初期化、`Rails`サーバー/開発サーバーの起動後、E2Eテストを実行する。
* `gulp rails` ... バックエンドで`Rails`サーバー起動
* `gulp rails:stop` ... バックエンドで起動した`Rails`サーバーを停止
* `gulp rails:setup` ... `bundle exec rake db:dev`のエイリアス


**オプション**

* `--prod` ... プロダクションビルドになる
* `--nosound` ... エラーを起こしてもうるさくない
* `--skipmin` ... プロダクションビルドでJSとCSSは結合のみ行い、圧縮しない
* `--seed` ... ログインとユーザー登録のときに初期値を入力した状態になる。E2Eテスト時は付けない。


### その他
* `npm test` ... `client/core/**/*.coffee`を対象にユニットテストする
* `npm start` ... `npm install && bower install && gulp --seed --nosound`が実行される。


# Run hokui.net on Nginx
1. Place the project or its symbolic link to `/var/www/hokui.net`
2. Boot Rails Server: `bundle exec rails s -e production`
3. Build client codes: `gulp build --prod`
4. Then, boot Nginx: `sudo nginx -c /var/www/hokui.net/nginx/nginx.conf` or `npm run nginx`


