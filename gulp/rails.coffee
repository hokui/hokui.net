child_process = require 'child_process'


scripts =
    setupRails: ->
        'bundle exec rake db:dev 1>/dev/null 2>/dev/null'
    startRails: ->
        'bundle exec rails s -d'
    stopRails: ->
        'if [ -f "./tmp/pids/server.pid" ]; then kill -QUIT `cat tmp/pids/server.pid`; fi'


g.task 'rails:setup', $.shell.task [
    scripts.setupRails()
]

g.task 'rails:stop', $.shell.task [
    scripts.stopRails()
]

g.task 'rails', ['rails:stop'], (cb)->
    $.util.log $.util.colors.magenta 'Booting Rails server..'
    child_process.exec scripts.startRails(), (err, stdout, stderr)->
        $.util.log $.util.colors.magenta 'Rails server is booted!'
        cb()

    process.on 'SIGINT', ->
        child_process.exec scripts.stopRails(), (err, stdout, stderr)->
            $.util.log $.util.colors.magenta 'Stop Rails server'
            process.exit()
