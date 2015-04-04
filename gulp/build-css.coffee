sort = require 'sort-stream'


g.task 'css:vendor', ['clean'], ->
    dest = if conf.prod then "#{conf.dest}/.cache/" else "#{conf.dest}/vendor/"

    g.src "#{conf.src}/vendor/**/*.scss"
    .pipe $.sass
        includePaths: [conf.bowerDir]
    .on 'error', onError
    .pipe $.autoprefixer()

    .pipe $.if conf.prod, $.concat 'vendor.css'

    .pipe g.dest dest



g.task 'css:common', ['clean'], ->
    dest = if conf.prod then "#{conf.dest}/.cache/" else "#{conf.dest}/style/"

    g.src "#{conf.src}/style/**/*.sass"
    .pipe $.sass
        sourceComments: 'normal'
        indentedSyntax: true
    .on 'error', onError
    .pipe $.autoprefixer()
    .pipe g.dest dest


g.task 'css:app:inject', ['clean'], ->
    targetFiles =
    g.src "#{conf.src}/{page,component}/**/*.sass", read: false
    .pipe sort (a, b)->
        a.path.localeCompare b.path

    g.src "#{conf.src}/app.sass"
    .pipe $.inject targetFiles,
        starttag: '// inject:sass'
        endtag: '// endinject'
        transform: (filePath, file, i, length)->
            filePath = filePath.replace "#{conf.src}/", ''
            return "@import \"#{filePath}\""
        addRootSlash: false

    .on 'error', onError
    .pipe g.dest "#{conf.src}/"


g.task 'css:app', ['clean', 'css:app:inject'], ->
    dest = if conf.prod then "#{conf.dest}/.cache/" else "#{conf.dest}/"

    g.src "#{conf.src}/app.sass"
    .pipe $.sass
        indentedSyntax: true
    .on 'error', onError
    .pipe $.autoprefixer()
    .pipe g.dest dest


g.task 'css', ['css:vendor', 'css:common', 'css:app']


g.task 'css:build', ['css'], (cb)->
    if not conf.prod
        return cb()
    # concat order
    # 1. vendor.css: vendor style
    # 2. common.css: common style
    # 3. app.css: app style

    target = [
        "#{conf.dest}/.cache/vendor.css"
        "#{conf.dest}/.cache/common.css"
        "#{conf.dest}/.cache/app.css"
    ]

    g.src target
    .pipe $.concat "app-#{conf.hash}.css"
    .pipe $.if conf.minify, $.minifyCss()
    .pipe g.dest "#{conf.dest}/"
