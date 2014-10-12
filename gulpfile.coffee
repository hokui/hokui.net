g = require 'gulp'
$ = do require 'gulp-load-plugins'

fs = require 'fs'
del = require 'del'


###*
manual inclusions
###
bowerFiles = require 'main-bower-files'
sort = require 'sort-stream'

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
            JSON.parse(fs.readFileSync '.bowerrc', 'utf8').directory ? throw 'e'
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
        @watching = false
        @setProd(isProd)


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
    g.src "#{conf.src}/static/**/*"
    .pipe g.dest "#{conf.dest}"


g.task 'copy', ['copy:fonts', 'copy:static']


g.task 'css:vendor', ['clean'], ->

    t = g.src "#{conf.src}/vendor/**/*.{sass,scss}"
    .pipe $.plumber()
    .pipe $.sass
        includePaths: conf.sassPath
        sourceComments: 'normal'

    .pipe $.autoprefixer()

    if conf.prod
        t = t
        .pipe $.concat 'vendor.css'

    t.pipe g.dest "#{conf.dest}/vendor"


g.task 'css:app:inject', ['clean'], ->
    target = [
        "#{conf.src}/{app,components}/**/*.{sass,scss}"
        "!#{conf.src}/app/app.sass"
    ]

    g.src "#{conf.src}/app/app.sass"
    .pipe $.inject(
        g.src(target, read: false),
            starttag: '// inject:sass'
            endtag: '// endinject'
            transform: (filePath, file, i, length)->
                filePath = filePath.replace('client/app/', '')
                filePath = filePath.replace('client/components/', '')
                filePath = filePath.replace('client/vendor/', '')
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
        includePaths: conf.sassPath
        sourceComments: 'normal'
    .pipe $.autoprefixer()
    .pipe g.dest "#{conf.dest}/app"


g.task 'css', ['css:app', 'css:vendor']


g.task 'build:css', ['css'], (cb)->
    if not conf.prod
        return cb()
    # concat order
    # 1. vendor/vendor.css: font-awesome and bootstrap
    # 2. app/app.css: app style

    target = [
        "#{conf.dest}/vendor/vender.css"
        "#{conf.dest}/app/app.css"
    ]

    t = g.src target
    .pipe $.concat 'app.min.css'
    .pipe $.minifyCss()
    .pipe g.dest "#{conf.dest}"



g.task 'js', ['clean'], ->
    t = g.src [
        "#{conf.src}/{components,app}/**/*.coffee",
        "!#{conf.bowerDir}/**/*.coffee"
    ]
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
    t = g.src ["#{conf.src}/{app,components}/**/*.jade"]
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

g.task 'build:html', ['html'], (cb)->
    cb()


g.task 'build:js', ['js', 'build:html', 'bower'], (cb)->
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
    .pipe $.concat 'app.min.js'
    .pipe $.uglify mangle: false
    .pipe g.dest "#{conf.dest}"

g.task 'clean:cache', ['build:css', 'build:js', 'build:html'], (cb)->
    if not conf.prod
        return cb()

    del [
        "#{conf.dest}/app"
        "#{conf.dest}/vendor"
    ], force: true, cb


g.task 'index', ['build:js', 'build:css', 'build:html', 'clean:cache'], ->
    ignorePath = ["#{conf.src}/", "#{conf.dest}/"]
    target = ''
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
            "#{conf.dest}/components/service.js"
            "#{conf.dest}/components/**/*.js"
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

    t.pipe g.dest "#{conf.dest}/"

    t


###*
watch tasks
###
g.task 'watch:index', ['index'], ->
    $.livereload.changed()
g.task 'watch:html', ['html'], ->
    $.livereload.changed()
g.task 'watch:css:app', ['css:app'], ->
    $.livereload.changed()
g.task 'watch:css:vendor', ['css:vendor'], ->
    $.livereload.changed()
g.task 'watch:js', ['js'], ->
    $.livereload.changed()


###*
integrated tasks
###


g.task 'build', [
    'copy'
    'build:html'
    'build:js'
    'build:css'
    'index'
]

g.task 'watch', ['build'], ->
    conf.watching = true
    $.livereload.listen()
    g.watch "#{conf.src}/index.jade", ['watch:index']
    g.watch "#{conf.src}/{app,components}/**/*.jade", ['watch:html']
    g.watch "#{conf.src}/{app,components}/**/*.{sass,scss}", ['watch:css:app']
    g.watch "#{conf.src}/vendor/**/*.{sass,scss}", ['watch:css:vendor']
    g.watch "#{conf.src}/**/*.coffee", ['watch:js']


g.task 'prod', (cb)->
    conf.setProd(true)
    cb()

g.task 'default', ['watch']



