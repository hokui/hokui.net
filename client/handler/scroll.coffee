module.exports = (Vue)->
    Vue.router.on '$pageUpdated', (context, next, past, status)->
        window.scrollTo 0, 0
