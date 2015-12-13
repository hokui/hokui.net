Vue = require 'vue'

Semester = require '../../../resource/semester'
ClassYear = require '../../../resource/class_year'
Subject = require '../../../resource/subject'

helper = require './helper'

module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        viewMode: 'detail'

    methods:
        semName: helper.name
        semYear: helper.year
        semSubjects: helper.subjects
    created: ->
        @$resolve
            subjects: Subject.get()
            classYears: ClassYear.get()
            semester: Semester.find id: (Number @$context().params.id)


    ready: ->
        # @viewMode = @$route().data.mode
        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode
