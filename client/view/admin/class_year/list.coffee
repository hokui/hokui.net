Vue = require 'vue'

ClassYear = require '../../../resource/class_year'

tO = (require '../../../lib/store').session.classYearTransformOption

module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        classYears: null

        tO: tO.get()

    methods:
        refresh: ->
            ClassYear.transformed @tO
            .then (items)=>
                @classYears = items

        sortById: ->
            if @tO.sort is 'id'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'id'
                @tO.inverted = false

            @refresh()

        sortByYear: ->
            if @tO.sort is 'year'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'year'
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
            tO.set v
            @refresh()
        , deep: true

        @refresh()
