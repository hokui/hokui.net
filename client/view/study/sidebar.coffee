Vue = require 'vue'

Semester = require '../../resource/semester'
ClassYear = require '../../resource/class_year'
Subject = require '../../resource/subject'


module.exports = Vue.extend
    template: do require './sidebar.jade'
    data: ->
        user: @$auth.user()
        items: null
        activeItem: null

    created: ->
        @$resolve
            classYears: ClassYear.get()
            semesters: Semester.find class_year_id: @user.id, true
            subjects: Subject.get()

        @$on '$pageUpdated', =>
            @activeItemIndex = -1
            for i, item of @items
                if item.active.test @$context().path
                    @activeItemIndex = i
                    break

    resolved: ->
        # @items = {}
        # for semester in @semesters
        #     cosno
