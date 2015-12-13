Vue = require 'vue'

News = require '../../../resource/news'

transformOption = (require '../../../lib/store').session.newsTransformOption

module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        newss: null

        tO: transformOption.get()

    methods:
        refresh: ->
            News.transformed @tO
            .then (items)=>
                @newss = items

        sortById: ->
            if @tO.sort is 'id'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'id'
                @tO.inverted = false

            @refresh()

        iconType: (name)->
            if @tO.sort is name
                if @tO.inverted
                    'fa-caret-down'
                else
                    'fa-caret-up'
            else
                'fa-sort'

    ready: ->
        @$watch 'tO', (v)->
            transformOption.set v
            @refresh()
        , deep: true

        @refresh()
