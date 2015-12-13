Vue = require 'vue'

Semester = require '../../../resource/semester'
ClassYear = require '../../../resource/class_year'
Subject = require '../../../resource/subject'

transformOption = (require '../../../lib/store').session.semesterTransformOption

helper = require './helper'

module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        semesters: null

        tO: transformOption.get()

        gradeFilters: [2, 3, 4, 5, 6]
        semesterFilters:
            a: '前期'
            b: '後期'

        searchText: ''
        matchedSubjectIds: null

    methods:
        refresh: ->
            Semester.transformed @tO
            .then (items)=>
                @semesters = items

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

        semName: helper.name
        semYear: helper.year
        semSubjects: helper.subjects
    created: ->
        @$useResponsive()
        @$resolve
            subjects: Subject.get().then (items)=>
                if s = (Subject.retrieve id: @tO.filter.subjectIds)
                    @searchText = s.title_ja
                items

            classYears: ClassYear.get()

    ready: ->
        @$watch 'searchText', (v)=>
            if not v
                @tO.filter.subjectIds = null
                transformOption.set @tO
                @refresh()
                return

            Subject.transformed
                filter:
                    search:
                        text: v
                        titleEn: true
                        titleJa: true
            , (items)=>
                ids = []
                for item in items
                    ids.push item.id
                @tO.filter.subjectIds = ids
                @transformOption.set @tO
                @refresh()


        @$watch 'tO', (v)->
            transformOption.set v
            @refresh()
        , deep: true

        if grade = Number @$context().query?.grade
            if 2 <= grade <= 6
                @tO.filter.grade = grade

        if cyId = Number @$context().query?.class_year_id
            @tO.filter.classYearId = cyId

        # @$router.trimQuery()


        @refresh()
