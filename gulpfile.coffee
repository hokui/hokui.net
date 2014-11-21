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


conf = new Conf(false)



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
    .pipe g.dest "#{conf.dest}"


g.task 'copy', ['copy:fonts', 'copy:static']


g.task 'css:vendor', ['clean'], ->
    # include bower directory
    t = g.src "#{conf.src}/vendor/**/*.{sass,scss}"
    .pipe $.plumber()
    .pipe $.sass
        includePaths: [conf.bowerDir]
        sourceComments: 'normal'

    .pipe $.autoprefixer()

    if conf.prod
        t = t
        .pipe $.concat 'vendor.css'

    t.pipe g.dest "#{conf.dest}/vendor"



g.task 'css:common', ['clean'], ->
    g.src "#{conf.src}/style/**/*.sass"
    .pipe $.plumber()
    .pipe $.sass
        sourceComments: 'normal'
    .pipe $.autoprefixer()
    .pipe g.dest "#{conf.dest}/style"


g.task 'css:app:inject', ['clean'], ->
    target = [
        "#{conf.src}/app/**/*.{sass,scss}"
        "!#{conf.src}/app/app.sass"
    ]

    g.src "#{conf.src}/app/app.sass"
    .pipe $.inject(
        g.src(target, read: false),
            starttag: '// inject:sass'
            endtag: '// endinject'
            transform: (filePath, file, i, length)->
                filePath = filePath.replace('client/app/', '')
                return "@import \"#{filePath}\""
            addRootSlash: false
    )
    .pipe sort (a, b)-> a < b
    .pipe g.dest "#{conf.src}/app/"


g.task 'css:app', ['clean', 'css:app:inject'], ->
    g.src "#{conf.src}/app/app.sass"
    .pipe $.plumber()
    .pipe g.dest "#{conf.src}/app/"
    .pipe $.sass
        sourceComments: 'normal'
    .pipe $.autoprefixer()
    .pipe g.dest "#{conf.dest}/app"


g.task 'css', ['css:vendor', 'css:common', 'css:app']


g.task 'css:build', ['css'], (cb)->
    if not conf.prod
        return cb()
    # concat order
    # 1. vendor/vendor.css: vendor style
    # 2. style/common.css: common style
    # 3. app/app.css: app style

    target = [
        "#{conf.dest}/vendor/**/*.css"
        "#{conf.dest}/style/**/*.css"
        "#{conf.dest}/app/**/*.css"
    ]

    t = g.src target
    .pipe $.concat "app-#{conf.hash}.css"
    if conf.minify
        t = t
        .pipe $.minifyCss()
    t.pipe g.dest "#{conf.dest}"



g.task 'js', ['clean'], ->
    t = g.src [
        "#{conf.src}/service/service.coffee"
        "#{conf.src}/service/**/*.coffee"
        "#{conf.src}/app/app.coffee"
        "#{conf.src}/app/**/*.coffee"
        "!#{conf.bowerDir}/**/*.coffee"
    ], base: "#{conf.src}/"
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.coffee
        bare: true
        sourceRoot: ''

    if conf.prod
        t = t
        .pipe $.ngAnnotate()
        .pipe $.concat 'app/app.js'
    else
        t = t
        .pipe $.sourcemaps.write()



    t.pipe g.dest "#{conf.dest}/"
    t


g.task 'bower', ['clean'], (cb)->
    if not conf.prod
        return cb()

    g.src bowerFiles()
    .pipe $.concat 'vendor.js'
    .pipe g.dest "#{conf.dest}/vendor"


g.task 'html', ['clean'], ->
    t = g.src ["#{conf.src}/{app,service}/**/*.jade"]
    .pipe $.plumber()
    .pipe $.jade pretty: not conf.prod

    if conf.prod
        t = t
        .pipe $.angularTemplatecache 'templates.js',
            module: conf.ngAppName
            root: '/'
        .pipe g.dest "#{conf.dest}/app/"
    else
        t = t
        .pipe g.dest "#{conf.dest}/"
    t

g.task 'html:build', ['html'], (cb)->
    cb()


g.task 'js:build', ['js', 'html:build', 'bower'], (cb)->
    if not conf.prod
        return cb()

    # concat order
    # 1. vendor/vendor.js: bower js
    # 2. app/app.js: app script
    # 3. app/templates.js: templates

    target = [
        "#{conf.dest}/vendor/vendor.js"
        "#{conf.dest}/app/app.js"
        "#{conf.dest}/app/templates.js"
    ]

    t = g.src target
    .pipe $.concat "app-#{conf.hash}.js"
    if conf.minify
        t = t
        .pipe $.uglify mangle: false
    t.pipe g.dest "#{conf.dest}"

g.task 'clean:cache', ['css:build', 'js:build', 'html:build'], (cb)->
    if not conf.prod
        return cb()

    del [
        "#{conf.dest}/style"
        "#{conf.dest}/app"
        "#{conf.dest}/vendor"
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
        # inject app.css last to override bootstrap styles and
        # app.js first to init angular correctly
        target = [
            "#{conf.dest}/vendor/**/*.css"
            "#{conf.dest}/style/**/*.css"
            "#{conf.dest}/app/**/*.css"

            "#{conf.dest}/service/service.js"
            "#{conf.dest}/service/**/*.js"
            "#{conf.dest}/app/app.js"
            "#{conf.dest}/app/**/*.js"
        ]


    t = g.src "#{conf.src}/index.jade"
    .pipe $.plumber()
    .pipe $.jade pretty: not conf.prod
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

    t

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

g.task 'watch', ['build'], ->
    conf.watching = true
    $.livereload.listen()
    g.watch "#{conf.src}/vendor/**/*.{sass,scss}", ['watch:css:vendor']
    g.watch "#{conf.src}/style/**/*.{sass,scss}", ['watch:css:common']
    g.watch "#{conf.src}/{app,service}/**/*.{sass,scss}", ['watch:css:app']

    g.watch "#{conf.src}/**/*.coffee", ['watch:js']

    g.watch "#{conf.src}/{app,service}/**/*.jade", ['watch:html']

    g.watch "#{conf.src}/index.jade", ['watch:index']

g.task 'prod', ()->
    conf.setProd true

g.task 'skipmin', ()->
    conf.minify = false

g.task 'default', ['build', 'watch']
