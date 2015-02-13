'use strict'

module.exports.config =
    directConnect: true
    seleniumAddress: 'http://localhost:4444/wd/hub'
    baseUrl: 'http://localhost:9000'
    framework: 'jasmine'

    specs: ['test/e2e/**/*.coffee']

    jasmineNodeOpts:
        showColors: true
        isVerbose: false
        defaultTimeoutInterval: 30000

    onPrepare: ->
        global.By = `by`
        # browser.ignoreSynchronization = true

