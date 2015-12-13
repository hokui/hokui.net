

module.exports = (Vue)->
    Vue.router.on '$pageUpdating', (context, next, past, status)->
        if context isnt '/'
            r = /\/$/
            if r.test context.path
                status.next = context.path.replace r, ''
