Vue = require 'vue'

Semester = require '../../../resource/semester'
ClassYear = require '../../../resource/class_year'
Subject = require '../../../resource/subject'

helper = require './helper'

module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        resolved: false
        semester: null
        classYears: null
        subjects: null

        viewMode: 'detail'

    methods:
        semName: helper.name
        semSubjects: helper.subjects
        
    ready: ->
        ClassYear.get (items)=>
            @classYears = items
        Subject.get (items)=>
            @subjects = items

        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode

            Semester.find id: (Number @$context().params.id), (item)=>
                @resolved = true
                @semester = item
