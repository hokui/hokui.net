g = require 'gulp'
$ = do require 'gulp-load-plugins'

fs = require 'fs'
del = require 'del'


###*
manual inclusions
###
bowerFiles = require 'main-bower-files'
seq = require 'run-sequence'


###*
preparalations
###

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
            bowerDir = JSON.parse(fs.readFileSync '.bowerrc', 'utf8').directory ? throw 'e'
        catch error
            'bower_components'
        )
        @sassPath = [
            "#{@bowerDir}"
            "#{@src}/app"
            "#{@src}/components"
            "#{@src}/vendor"
        ]
        @ngAppName = 'hokuiApp'
        @setProd(isProd)


conf = new Conf(false)



###*
tasks
###

g.task 'clean', (cb)->
    del [
        "#{conf.dest}/**/*"
        "!#{conf.bowerDir}"
        "!#{conf.bowerDir}/**/*"
    ], cb

g.task 'clean:cache', (cb)->
    del [
        "#{conf.dest}/app"
        "#{conf.dest}/vendor"
    ], cb


g.task 'copy:fonts', ()->
    g.src "#{conf.bowerDir}/font-awesome/fonts/**/*"
    .pipe g.dest "#{conf.dest}/fonts/"


g.task 'copy:static', ()->
    g.src "#{conf.src}/static/**/*"
    .pipe g.dest "#{conf.dest}"


g.task 'css:vendor', ['copy:fonts'], ->

    src = "#{conf.src}/vendor/**/*.{sass,scss}"
    dest = "#{conf.dest}/vendor"

    t = g.src src
    .pipe $.plumber()
    .pipe $.sass {
        includePaths: conf.sassPath
        sourceComments: 'normal'
    }
    .pipe $.autoprefixer()

    if conf.prod
        t.pipe $.concat 'vendor.css'
        .pipe g.dest dest
    else
        t.pipe g.dest dest


g.task 'css:app', ->
    src = "#{conf.src}/app/app.sass"
    dest = "#{conf.dest}/app"

    target = [
        "#{conf.src}/{app,components}/**/*.{sass,scss}"
        "!#{conf.src}/app/app.sass"
    ]

    t = g.src src
    .pipe $.plumber()
    .pipe $.inject(
        g.src(target, read: false),
        {
            starttag: '// inject:sass'
            endtag: '// endinject'
            transform: (filePath, file, i, length)->
                filePath = filePath.replace('client/app/', '')
                filePath = filePath.replace('client/components/', '')
                filePath = filePath.replace('client/vendor/', '')
                return "@import \"#{filePath}\""
            addRootSlash: false
        }
    )
    .pipe g.dest "#{conf.src}/app/"
    .pipe $.sass {
        includePaths: conf.sassPath
        sourceComments: 'normal'
    }
    .pipe $.autoprefixer()
    .pipe g.dest dest


g.task 'css', ['css:app', 'css:vendor']


g.task 'js', ->
    t = g.src ["#{conf.src}/**/*.coffee", "!#{conf.bowerDir}/**/*.coffee"]
    .pipe $.sourcemaps.init()
    .pipe $.plumber()
    .pipe $.coffee(
        bare: true
        sourceRoot: ''
    )
    .pipe $.sourcemaps.write()

    if conf.prod
        t
        .pipe $.ngAnnotate()
        .pipe $.concat 'app/app.js'
        .pipe g.dest "#{conf.dest}/"
    else
        t
        .pipe g.dest "#{conf.dest}/"
    t


g.task 'bower', ->
    g.src bowerFiles()
    .pipe $.concat('vendor.js')
    .pipe g.dest("#{conf.dest}/vendor")


g.task 'html', ->
    t = g.src ["#{conf.src}/{app,components}/**/*.jade"]
    .pipe $.plumber()
    .pipe $.jade pretty: not conf.prod

    if conf.prod
        t.pipe $.angularTemplatecache {
            module: conf.ngAppName
            root: '/'
        }
        .pipe g.dest "#{conf.dest}/app/"
    else
        t.pipe g.dest "#{conf.dest}/"
    t


g.task 'index', ->
    if conf.prod
        target = [
            "#{conf.dest}/**/*.js"
            "#{conf.dest}/**/*.css"
        ]
    else
        # inject app.css last to override bootstrap styles and
        # app.js first to init angular correctly
        target = [
            "#{conf.dest}/vendor/**/*.css"
            "#{conf.dest}/app/app.css"
            "#{conf.dest}/app/app.js"
            "#{conf.dest}/{app,components}/**/*.js"
        ]


    t = g.src "#{conf.src}/index.jade"
    .pipe $.plumber()
    .pipe $.jade pretty: not conf.prod
    .pipe $.inject(
        g.src(target, read: false),
            ignorePath: ['public/', 'client/', '/dist']
    )

    if not conf.prod
        t.pipe $.inject(
            g.src(bowerFiles(),
                    base: conf.bowerDir
                    read: false),
                ignorePath: ['public/', 'client/', '/dist']
                name: 'bower'
        )

    t.pipe g.dest "#{conf.dest}/"

    t




g.task 'min:js', ->
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
    .pipe $.concat 'app.min.js'
    .pipe $.uglify mangle: false
    .pipe g.dest "#{conf.dest}"


g.task 'min:css', ->
    # concat order
    # 1. vendor/vendor.css: font-awesome and bootstrap
    # 2. app/app.css: app style

    target = [
        "#{conf.dest}/vendor/vendor.css"
        "#{conf.dest}/app/app.css"
    ]

    t = g.src target
    .pipe $.concat 'app.min.css'
    .pipe $.minifyCss()
    .pipe g.dest("#{conf.dest}")



###*
integrated tasks
###

g.task 'watch', ->
    $.livereload.listen()
    g.watch "#{conf.src}/index.jade", ['index']
    g.watch "#{conf.src}/{app,components}/**/*.jade", ['html']
    g.watch "#{conf.src}/{app,components}/**/*.{sass,scss}", ['css:app']
    g.watch "#{conf.src}/vendor/**/*.{sass,scss}", ['css:vendor']
    g.watch "#{conf.src}/**/*.coffee", ['js']


g.task 'build', (cb)->
    if conf.prod
        seq(
            'clean'
            ['html', 'css', 'js', 'bower']
            ['min:js', 'min:css']
            'clean:cache'
            ['index', 'copy:static']
            cb
        )
    else
        seq(
            'clean'
            ['js', 'html', 'css']
            ['index', 'copy:static']
            cb
        )


g.task 'prod', ->
    conf.setProd(true)


g.task 'default', (cb)->
    seq(
        'build'
        'watch'
        cb
    )

