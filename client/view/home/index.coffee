Vue = require 'vue'

News = require '../../resource/news'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        user: @$auth.user()
    created: ->
        @$resolve
            newss: News.get()
