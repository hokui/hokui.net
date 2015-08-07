Vue = require 'vue'

News = require '../../../resource/news'


module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        resolved: false
        news: null
        viewMode: 'detail'
        previewing: false

    ready: ->

        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode

            News.find id: (Number @$context().params.id), (item)=>
                @resolved = true
                @news = item
