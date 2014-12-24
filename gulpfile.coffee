###*
preparalations
###
g = require 'gulp'
$ = do require 'gulp-load-plugins'

fs = require 'fs'
del = require 'del'
bowerFiles = require 'main-bower-files'
sort = require 'sort-stream'
require 'date-utils'
play = require 'play'

sounds =
    error: 'misc/error.mp3'

p = console.log

class Conf
    setProd: (isProd)->
        if isProd?
            @prod = isProd
        else
            @prod = false
        @dest = if @prod then 'dist' else 'public'

    constructor: (isProd)->
        @src = 'client'
        @bowerDir = (try
            JSON.parse(fs.readFileSync '.bowerrc', 'utf8').directory ? throw 'e'
        catch error
            'bower_components'
        )
        @ngAppName = 'hokuiApp'
        @watching = false
        @minify = true
        @static = 'static'
        @setProd(isProd)
        @hash = (new Date()).toFormat("YYYYMMDDHH24MISS")
        @useSounds = true

conf = new Conf(false)

onError = (arg)->
    if conf.useSounds
        play.sound sounds.error
    console.warn "plugin: #{arg.plugin}"
    console.warn "error: #{arg.message}"
    process.exit 1


###*
tasks
###

g.task 'clean', (cb)->
    if conf.watching
        return cb()

    del [
        "#{conf.dest}/**/*"
        "!#{conf.bowerDir}"
        "!#{conf.bowerDir}/**/*"
    ], cb



g.task 'copy:fonts', ['clean'], ->
    g.src "#{conf.bowerDir}/font-awesome/fonts/**/*"
    .pipe g.dest "#{conf.dest}/fonts/"


g.task 'copy:static', ['clean'], ->
    g.src "#{conf.static}/**/*"
    .pipe g.dest "#{conf.dest}/"


g.task 'copy', ['copy:fonts', 'copy:static']



g.task 'css:vendor', ['clean'], ->
    t = g.src "#{conf.src}/vendor/**/*.{sass,scss}"
    .pipe $.sass
        includePaths: [conf.bowerDir]
        sourceComments: 'normal'
    .on 'error', onError
    .pipe $.autoprefixer()

    if conf.prod
        t = t
        .pipe $.concat 'vendor.css'

    t.pipe g.dest "#{conf.dest}/vendor/"


g.task 'css:common', ['clean'], ->
    g.src "#{conf.src}/style/**/*.sass"
    .pipe $.sass
        sourceComments: 'normal'
    .on 'error', onError
    .pipe $.autoprefixer()
    .pipe g.dest "#{conf.dest}/style/"


g.task 'css:app:inject', ['clean'], ->
    target = [
        "#{conf.src}/{page,component}/**/*.{sass,scss}"
    ]

    g.src "#{conf.src}/app.sass"
    .pipe $.inject(
        g.src(target, read: false),
            starttag: '// inject:sass'
            endtag: '// endinject'
            transform: (filePath, file, i, length)->
                filePath = filePath.replace "#{conf.src}/", ''
                return "@import \"#{filePath}\""
            addRootSlash: false
    )
    .on 'error', onError
    .pipe sort (a, b)-> a < b
    .pipe g.dest "#{conf.src}/"


g.task 'css:app', ['clean', 'css:app:inject'], ->
    g.src "#{conf.src}/app.sass"
    .pipe $.sass
        sourceComments: 'normal'
    .on 'error', onError
    .pipe $.autoprefixer()
    .pipe g.dest "#{conf.dest}/"


g.task 'css', ['css:vendor', 'css:common', 'css:app']


g.task 'css:build', ['css'], (cb)->
    if not conf.prod
        return cb()
    # concat order
    # 1. vendor/vendor.css: vendor style
    # 2. style/common.css: common style
    # 3. app.css: app style

    target = [
        "#{conf.dest}/vendor/vendor.css"
        "#{conf.dest}/style/common.css"
        "#{conf.dest}/app.css"
    ]

    t = g.src target
    .pipe $.concat "app-#{conf.hash}.css"
    if conf.minify
        t = t
        .pipe $.minifyCss()
    t.pipe g.dest "#{conf.dest}/"



g.task 'js', ['clean'], ->
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
        target.push "!#{conf.src}/config/development/*.coffee"
    else
        target.push "!#{conf.src}/config/production/*.coffee"

    t = g.src target, base: "#{conf.src}/"
    .pipe $.sourcemaps.init()
    .pipe $.coffee
        bare: true
        sourceRoot: ''
    .on 'error', onError

    if conf.prod
        t = t
        .pipe $.ngAnnotate()
        .pipe $.concat 'app.js'
    else
        t = t
        .pipe $.sourcemaps.write()

    t.pipe g.dest "#{conf.dest}/"


g.task 'bower', ['clean'], (cb)->
    if not conf.prod
        return cb()

    g.src bowerFiles()
    .pipe $.concat 'vendor.js'
    .pipe g.dest "#{conf.dest}/vendor/"


g.task 'html', ['clean'], ->
    target = [
        "#{conf.src}/**/*.jade"
        "!#{conf.src}/index.jade"
    ]

    t = g.src target
    .pipe $.jade pretty: not conf.prod
    .on 'error', onError

    if conf.prod
        t = t
        .pipe $.minifyHtml
                spare: true
                empty: true
                conditionals: true
                quotes: true
        .pipe $.angularTemplatecache 'templates.js',
            module: conf.ngAppName
            root: '/'
    t.pipe g.dest "#{conf.dest}/"

g.task 'html:build', ['html'], (cb)->
    cb()


g.task 'js:build', ['js', 'html:build', 'bower'], (cb)->
    if not conf.prod
        return cb()

    # concat order
    # 1. vendor/vendor.js: bower js
    # 2. app.js: app script
    # 3. templates.js: templates

    target = [
        "#{conf.dest}/vendor/vendor.js"
        "#{conf.dest}/app.js"
        "#{conf.dest}/templates.js"
    ]

    t = g.src target
    .pipe $.concat "app-#{conf.hash}.js"
    if conf.minify
        t = t
        .pipe $.uglify()
    t.pipe g.dest "#{conf.dest}/"



g.task 'clean:cache', ['css:build', 'js:build', 'html:build'], (cb)->
    if not conf.prod
        return cb()

    del [
        "#{conf.dest}/style"
        "#{conf.dest}/app"
        "#{conf.dest}/vendor"
        "#{conf.dest}/templates.js"
        "#{conf.dest}/app.js"
        "#{conf.dest}/app.css"
    ], cb



g.task 'index', ['js:build', 'css:build', 'html:build', 'clean:cache'], ->
    ignorePath = ["#{conf.src}/", "#{conf.dest}/"]
    target = ''
    if conf.prod
        target = [
            "#{conf.dest}/*.js"
            "#{conf.dest}/*.css"
        ]
    else
        target = [
            "#{conf.dest}/vendor/**/*.css"
            "#{conf.dest}/style/**/*.css"
            "#{conf.dest}/app.css"

            "#{conf.dest}/core/*.js"
            "#{conf.dest}/core/**/*.js"
            "#{conf.dest}/component/*.js"
            "#{conf.dest}/component/**/*.js"
            "#{conf.dest}/page/*.js"
            "#{conf.dest}/page/**/*.js"
            "#{conf.dest}/config/*.js"
            "#{conf.dest}/config/**/*.js"
            "#{conf.dest}/app.js"
        ]


    t = g.src "#{conf.src}/index.jade"
    .pipe $.jade pretty: not conf.prod
    .on 'error', onError
    .pipe $.inject g.src(target), ignorePath: ignorePath

    if not conf.prod
        t = t
        .pipe $.inject(
            g.src(bowerFiles(),
                    base: conf.bowerDir
                    read: false),
                ignorePath: ignorePath
                name: 'bower'
        )
    else
        if conf.minify
            t = t
            .pipe $.minifyHtml
                spare: true
                empty: true
                conditionals: true
                quotes: true

    t.pipe g.dest "#{conf.dest}/"



###*
watch tasks
###

g.task 'watch:css:vendor', ['css:vendor'], ->
    $.livereload.changed()
g.task 'watch:css:common', ['css:common'], ->
    $.livereload.changed()
g.task 'watch:css:app', ['css:app'], ->
    $.livereload.changed()

g.task 'watch:js', ['js'], ->
    $.livereload.changed()

g.task 'watch:html', ['html'], ->
    $.livereload.changed()

g.task 'watch:index', ['index'], ->
    $.livereload.changed()


###*
integrated tasks
###

g.task 'build', [
    'copy'
    'html:build'
    'js:build'
    'css:build'
    'clean:cache'
    'index'
]

g.task 'watch', ['build'], (cb)->
    if conf.prod
        return cb()
    conf.watching = true
    $.livereload.listen()
    g.watch "#{conf.src}/vendor/**/*.{sass,scss}", ['watch:css:vendor']
    g.watch "#{conf.src}/style/**/*.{sass,scss}", ['watch:css:common']
    g.watch "#{conf.src}/{page,core,component}/**/*.{sass,scss}", ['watch:css:app']

    g.watch "#{conf.src}/**/*.coffee", ['watch:js']

    g.watch "#{conf.src}/{page,core,component}/**/*.jade", ['watch:html']

    g.watch "#{conf.src}/index.jade", ['watch:index']


g.task 'serve', ['build'], ->
    g.src "#{conf.dest}/"
    .pipe $.webserver
        port: 9000
        fallback: 'index.html'
        livereload: not conf.prod
        proxies:[
            source: '/api'
            target: 'http://localhost:3000/api'
        ]

g.task 'prod', ->
    conf.setProd true

g.task 'skipmin', ->
    conf.minify = false

g.task 'silent', ->
    conf.useSounds = false

g.task 'default', ['build', 'watch', 'serve']
