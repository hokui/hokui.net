Vue = require 'vue'

News = require '../../../resource/news'
parseError = require '../../../lib/parse_error'

marked = require 'marked'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        news: null
        editing: false
        errors: {}
        previewing: false

        compiledText: ''

    methods:
        performSave: (e)->
            e.preventDefault()

            @news.$save (item)=>
                console.log 'add'
                @$router.go "/admin/news/#{item.id}"
                @$toast if @editing then 'お知らせを更新しました' else 'お知らせを追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'

        preview: ->
            @compiledText = marked @news.text
            @previewing = true

    ready: ->

        if id = Number @$context().params.id
            @editing = true
            News.find id: id, (item)=>
                @resolved = true
                @news = item.$copy()
        else
            @editing = false
            @news = News.create
                title: ''
                text: ''
