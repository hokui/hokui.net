
__context = null

handler = (e)->
    if __context?.path is this.pathname
        e.preventDefault()

module.exports = (Vue)->
    Vue.router.on '$pageUpdating', (context, next, past, status)->
        links = document.querySelectorAll 'a'
        for link in links
            link.removeEventListener 'click', handler

    Vue.router.on '$pageUpdated', (context, next, past, status)->
        __context = context
        links = document.querySelectorAll 'a'
        for link in links
            link.addEventListener 'click', handler
