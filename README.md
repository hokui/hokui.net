# hokui.net

**Project**  
[![Codeship Status for hokui/hokui.net](https://codeship.com/projects/1b154840-a7bd-0132-be13-5ac1da2e580b/status?branch=master)](https://codeship.com/projects/67249)  
**Backend**  
[![Code Climate](https://codeclimate.com/github/hokui/hokui.net/badges/gpa.svg)](https://codeclimate.com/github/hokui/hokui.net)
[![Test Coverage](https://codeclimate.com/github/hokui/hokui.net/badges/coverage.svg)](https://codeclimate.com/github/hokui/hokui.net)  

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

mailing listを実行
```
git clone https://github.com/hokui/mailing_list
cd mailing_list
bundle install --path .bundle/gems --jobs=4
cp config/application.example.yml config/application.yml
bundle exec rake db:migrate
bundle exec rails s -p 3001
```

## フロントエンド
### 設計
* `client/` ... クライントのソースコード
  * `assets/` ... 静的ファイル
  * `lib/` ... ビジネスロジックっぽいものを集める
  * `component/` ... 共通で使用するVue componentを宣言
  * `view/` ... ルーティングに応じて`v-view`にバインドされるコンポーネントを配置
  * `style/` ... スタイルシート。`index.sass`から開始
* `build/` ... ビルド済みパッケージの出力場所。dev/prodで共通


### commands
* `npm start` ... 開発サーバー起動。`http://localhost:8080`
* `npm run dev` ... デバッグでビルド
* `npm run prod` ... プロダクションビルド
