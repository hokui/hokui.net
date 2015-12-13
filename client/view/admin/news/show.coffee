Vue = require 'vue'

News = require '../../../resource/news'


module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        viewMode: 'detail'
        previewing: false

    ready: ->
        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode
            @$resolve
                news: News.find id: (Number @$context().params.id)
