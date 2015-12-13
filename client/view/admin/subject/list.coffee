Vue = require 'vue'

Subject = require '../../../resource/subject'

store = require '../../../lib/store'
transformOption = store.session.subjectTransformOption

module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        subjects: null

        tO: transformOption.get()

    methods:
        refresh: ->
            Subject.transformed @tO
            .then (items)=>
                @subjects = items

        sortById: ->
            if @tO.sort is 'id'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'id'
                @tO.inverted = false

            @refresh()

        sortByTitleJa: ->
            if @tO.sort is 'titleJa'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'titleJa'
                @tO.inverted = false

            @refresh()

        sortByTitleEn: ->
            if @tO.sort is 'titleEn'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'titleEn'
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

        applyFilter: (subject)->
            tO = store.session.semesterTransformOption.get()
            tO.filter.subjectIds = [subject.id]
            store.session.semesterTransformOption.set tO

    ready: ->
        @$watch 'tO', (v)->
            transformOption.set v
            @refresh()
        , deep: true

        @refresh()
