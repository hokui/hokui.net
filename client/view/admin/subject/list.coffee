Vue = require 'vue'

Subject = require '../../../resource/subject'

setting = require '../../../lib/setting'

module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        subjects: null

        transformOption: setting.subjectTransformOption.get()

    methods:
        refresh: ->
            Subject.transformed @transformOption
            , (items)=>
                @subjects = items

        sortById: ->
            if @transformOption.sort is 'id'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'id'
                @transformOption.inverted = false

            @refresh()

        sortByTitleJa: ->
            if @transformOption.sort is 'titleJa'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'titleJa'
                @transformOption.inverted = false

            @refresh()

        sortByTitleEn: ->
            if @transformOption.sort is 'titleEn'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'titleEn'
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
            setting.subjectTransformOption.set v
            @refresh()
        , deep: true

        @refresh()
