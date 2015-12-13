Vue = require 'vue'

News = require '../../../resource/news'
parseError = require '../../../lib/parse_error'

marked = require 'marked'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        errors: {}
        previewing: false
        compiledText: ''
    methods:
        performSave: (e)->
            e.preventDefault()

            @news.$save (item)=>
                @$router.go "/admin/news/#{item.id}"
                @$toast if @editing then 'お知らせを更新しました' else 'お知らせを追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'

        preview: ->
            @compiledText = marked @news.text
            @previewing = true

    created: ->
        @$resolve
            news: do =>
                if id = Number @$context().params.id
                    News.find id: id
                    .then (item)->
                        item.$copy()
                else
                    News.create
                        title: ''
                        text: ''
