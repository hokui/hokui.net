config = require '../config'

module.exports = (Vue)->
    Vue.router.on '$pageUpdated', (context, next, past)->
        if t = next.data.title
            title = t + ' | ' + config.siteName
        else
            title = config.siteName

        document.title = title
