bundle exec rspec
npm test
# bash scripts/e2e_on_sauce.sh

export COVERALLS_REPO_TOKEN=GWDKAQhpqOcb4urILg0JZze6TUdykiRbN
cat ./build-report/lcov.info | ./node_modules/coveralls/bin/coveralls.js
