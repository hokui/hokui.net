g = require 'gulp'
$ = do require 'gulp-load-plugins'


g.task 'default', ->
    console.log '私の名前は秘伝のタレ'

g.task 'lint', ->
    g.src 'client/**/*.coffee'
    .pipe $.coffeelint 'coffeelint.json'
    .pipe $.coffeelint.reporter()
