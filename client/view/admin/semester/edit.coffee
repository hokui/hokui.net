Vue = require 'vue'

Semester = require '../../../resource/semester'
ClassYear = require '../../../resource/class_year'
Subject = require '../../../resource/subject'

parseError = require '../../../lib/parse_error'
helper = require './helper'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        searchSubjectText: ''
        showSelectedSubjects: false
        identifierOptions: do ->
            options = [
                value: null
                text: '-'
            ]
            for grade in [2..6]
                options
                for ab in [
                    code:'a'
                    text:'前期'
                ,
                    code:'b'
                    text: '後期'
                ]
                    options.push
                        value: "#{grade}#{ab.code}"
                        text: "#{grade}年#{ab.text}"
            options
        errors: {}

    methods:
        semSubjects: helper.subjects

        performSave: (e)->
            e.preventDefault()

            @semester.$save().then (item)=>
                @$router.go "/admin/semester/#{item.id}"
                @$toast if @editing then 'カリキュラムを更新しました' else 'カリキュラムを追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'

    created: ->

        @$resolve
            semester: do =>
                if id = Number @$context().params.id
                    console.log id
                    Semester.find id: id
                    .then (item)->
                        item.$copy()
                else
                    s = Semester.create
                        class_year_id: null
                        identifier: null
                        subject_ids: []

            subjects: Subject.get()
            classYears: ClassYear.get()


    directives:
        select:
            twoWay: true
            cast: (v)->
                if @el.getAttribute 'number'
                    (Number v) or v
                else
                    v
            bind: ->
                @handler = (->
                    if (idx = @value.indexOf @cast(@el.value)) > -1
                        if not @el.checked
                            @value.splice idx, 1
                    else
                        if @el.checked
                            @value.push @cast(@el.value)
                    @$set @value
                ).bind this
                @el.addEventListener 'change', @handler

            update: (v)->
                @value = v
                @el.checked = (v.indexOf @cast(@el.value)) > -1

            unbind: ->
                @el.removeEventListener 'change', @handler
