'use strict'

config =
    baseUrl: 'http://localhost:9000'

    specs: ['test/e2e/**/*.coffee']

    framework: 'jasmine'
    jasmineNodeOpts:
        showColors: true
        isVerbose: false
        defaultTimeoutInterval: 100000

    onPrepare: ->
        global.By = `by`
        # browser.ignoreSynchronization = true

if not process.env.TRAVIS_BUILD_NUMBER
    # Local Configuration
    config.directConnect = true
    config.seleniumAddress = 'http://localhost:4444/wd/hub'
    config.capabilities =
        'browserName': 'chrome'
else
    # TravisCI Configuration
    config.sauceUser = process.env.SAUCE_USERNAME
    config.sauceKey = process.env.SAUCE_ACCESS_KEY
    config.capabilities =
        'browserName': 'chrome',
        'tunnel-identifier': process.env.TRAVIS_JOB_NUMBER,
        'build': process.env.TRAVIS_BUILD_NUMBER,
        'name': 'E2E Tests@hokui/hokui.net'


module.exports.config = config
