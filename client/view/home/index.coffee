Vue = require 'vue'
config = require '../../config'

News = require '../../resource/news'

setting = require '../../lib/setting'


module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        newss: null
        user: @$auth.user()
        showNews: false
    methods:
        toggleNewsDialog: ->
            @showNews = not @showNews


    ready: ->
        News.get (items)=>
            @newss = items

    components:
        dialog:
            props: ['open']
            template: do require './d.jade'
