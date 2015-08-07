Vue = require 'vue'
marked = require 'marked'

config = require '../../config'
News = require '../../resource/news'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        newss: null
        user: @$auth.user()
        showNews: false
        previewing: false

        selectedNews: null
        selectedNewsContent: ''

    methods:
        preview: (news)->
            @previewing = true
            @selectedNews = news
            @selectedNewsContent = marked news.text

    created: ->
        @$resolve
            newss: News.get()
