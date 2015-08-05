Vue = require 'vue'

ClassYear = require '../../../resource/class_year'

setting = require '../../../lib/setting'

module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        classYears: null

        transformOption: setting.classYearTransformOption.get()

    methods:
        refresh: ->
            ClassYear.transformed @transformOption
            , (items)=>
                @classYears = items

        sortById: ->
            if @transformOption.sort is 'id'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'id'
                @transformOption.inverted = false

            @refresh()

        sortByYear: ->
            if @transformOption.sort is 'year'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'year'
                @transformOption.inverted = false

            @refresh()

        iconType: (name)->
            if @transformOption.sort is name
                if @transformOption.inverted
                    'fa-caret-down'
                else
                    'fa-caret-up'
            else
                'fa-sort'

    ready: ->
        @$watch 'transformOption', (v)->
            setting.classYearTransformOption.set v
            @refresh()
        , deep: true

        @refresh()
