Vue = require 'vue'

Subject = require '../../../resource/subject'
parseError = require '../../../lib/parse_error'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        subject: null
        editing: false
        errors: {}

    methods:
        performSave: (e)->
            e.preventDefault()

            @subject.$save().then (item)=>
                @$router.go "/admin/subject/#{item.id}"
                @$toast if @editing then '教科を更新しました' else '教科を追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'
    validator:
        validates:
            latin: (v)->
                /^[0-9a-z_]+$/.test v

    created: ->
        @$resolve
            subject: do =>
                if id = Number @$context().params.id
                    Subject.find id: id
                    .then (item)->
                        item.$copy()
                else
                    Subject.create
                        title_ja: ''
                        title_en: ''
    resolved: ->
        @$watch 'subject.title_ja', (e)=>
            @errors.title_ja = null
        @$watch 'subject.title_en', (e)=>
            @errors.title_en = null
