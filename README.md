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

### commands
* `npm start` ... Boot dev server `http://localhost:8080`
* `npm run dev` ... Development build
* `npm run prod` ... production build
* `gulp lint` ... Run coffeelint
