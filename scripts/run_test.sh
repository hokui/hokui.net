bundle exec rspec
npm test
# bash scripts/e2e_on_sauce.sh

COVERALLS_SERVICE_NAME=codeship
COVERALLS_REPO_TOKEN=GlzGIL1scY32eexp5V2Q8QDkrPnBci22e
cat ./build-report/lcov.info | ./node_modules/coveralls/bin/coveralls.js;
