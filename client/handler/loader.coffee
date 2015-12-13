module.exports = (Vue)->
    Vue.resolver.on '$resolving', ->
        Vue.loader()

    Vue.resolver.on '$resolved', ->
        Vue.loader false

    Vue.resolver.on '$rejected', ->
        Vue.loader false
