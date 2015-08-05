Vue = require 'vue'

ClassYear = require '../../../resource/class_year'
parseError = require '../../../lib/parse_error'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        cy: null
        editing: false
        errors: {}

    methods:
        performSave: (e)->
            e.preventDefault()

            @cy.$save (item)=>
                @$router.go "/admin/class_year/#{item.id}"
                @$toast if @editing then '学年を更新しました' else '学年を追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'

    ready: ->
        startWatching = =>
            @$watch 'cy.year', (e)=>
                @errors.year = null


        if @$context().params.id
            @editing = true
            ClassYear.find id: (Number @$context().params.id), (item)=>
                @resolved = true
                @cy = item.$copy()
                startWatching()
        else
            @editing = false
            @cy = ClassYear.create year: null
            startWatching()
