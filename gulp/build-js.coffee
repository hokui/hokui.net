lazypipe = require 'lazypipe'

bowerFiles = require 'main-bower-files'


g.task 'js', ['clean'], ->
    dest = if conf.prod then "#{conf.dest}/.cache/" else "#{conf.dest}/"

    target = [
        "#{conf.src}/core/*.coffee"
        "#{conf.src}/core/**/*.coffee"
        "#{conf.src}/component/*.coffee"
        "#{conf.src}/component/**/*.coffee"
        "#{conf.src}/page/*.coffee"
        "#{conf.src}/page/**/*.coffee"
        "#{conf.src}/config/*.coffee"
        "#{conf.src}/config/**/*.coffee"
        "#{conf.src}/*.coffee"
        "!#{conf.bowerDir}/**/*.coffee"
    ]
    if conf.prod
        target.push "!#{conf.src}/config/development/**/*.coffee"
    else
        target.push "!#{conf.src}/config/production/**/*.coffee"

    if not conf.seeding
        target.push "!#{conf.src}/config/seed/**/*.coffee"

    anotateAndConcat = lazypipe()
        .pipe $.ngAnnotate
        .pipe $.concat, 'app.js'

    g.src target, base: "#{conf.src}/"
    .pipe $.sourcemaps.init()
    .pipe $.coffee
        bare: true
        sourceRoot: ''
    .on 'error', onError

    .pipe $.if conf.prod, anotateAndConcat(), $.sourcemaps.write()
    .pipe g.dest dest


g.task 'bower', ['clean'], (cb)->
    if not conf.prod
        return cb()

    g.src bowerFiles()
    .pipe $.concat 'vendor.js'
    .pipe g.dest "#{conf.dest}/.cache/"


g.task 'js:build', ['js', 'html:build', 'bower'], (cb)->
    if not conf.prod
        return cb()

    # concat order
    # 1. vendor.js: bower js
    # 2. app.js: app script
    # 3. templates.js: templates

    target = [
        "#{conf.dest}/.cache/vendor.js"
        "#{conf.dest}/.cache/app.js"
        "#{conf.dest}/.cache/templates.js"
    ]

    g.src target
    .pipe $.concat "app-#{conf.hash}.js"
    .pipe $.if conf.prod, $.uglify()
    .pipe g.dest "#{conf.dest}/"
