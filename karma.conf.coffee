module.exports = (config) ->
    bowerFiles = require 'main-bower-files'

    files = [
        'client/components/service.coffee'
        'client/components/**/*.coffee'
        'client/app/app.coffee'
        'client/app/**/*.coffee'
        'client/spec/global.js'
        'client/spec/**/*.coffee'
    ]
    files = bowerFiles(includeDev: true).concat files

    autoWatch = false

    config.set

        basePath: ''

        frameworks: ['jasmine']

        files: files

        exclude: []

        preprocessors:
            'client/{app,components}/**/*.coffee': ['coverage']
            'client/spec/**/*.coffee': ['coffee']

        reporters: ['progress', 'coverage']

        port: 9876

        colors: true

        logLevel: config.LOG_INFO

        autoWatch: autoWatch

        browsers: ['PhantomJS']

        singleRun: not autoWatch

        coverageReporter:
            type : 'html',
            dir : 'coverage/'



