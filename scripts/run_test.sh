bundle exec rspec
npm test
# bash scripts/e2e_on_sauce.sh

cat ./build-report/lcov.info | ./node_modules/coveralls/bin/coveralls.js;
