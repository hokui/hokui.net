

scripts =
    startE2ETest: ->
        'protractor protractor.conf.js'


g.task 'e2e', $.shell.task [
    scripts.startE2ETest()
]


g.task 'run-e2e', ['serve', 'rails:setup', 'rails'], ->
    $.shell.task([
        scripts.startE2ETest()
        scripts.stopRails()
    ])()
    .on 'error', ->
        process.exit 1
    .on 'end', ->
        process.exit 0
