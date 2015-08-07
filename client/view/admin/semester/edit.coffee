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

            @subject.$save (item)=>
                @$router.go "/admin/subject/#{item.id}"
                @$toast if @editing then '教科を更新しました' else '教科を追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'
    validator:
        validates:
            latin: (v)->
                /^[0-9a-z_]+$/.test v

    ready: ->
        startWatching = =>
            @$watch 'subject.title_ja', (e)=>
                @errors.title_ja = null
            @$watch 'subject.title_en', (e)=>
                @errors.title_en = null


        if id = Number @$context().params.id
            @editing = true
            Subject.find id: id, (item)=>
                @resolved = true
                @subject = item.$copy()
                startWatching()
        else
            @editing = false
            @subject = Subject.create
                title_ja: ''
                title_en: ''
            startWatching()
