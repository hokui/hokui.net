Vue = require 'vue'

ClassYear = require '../../../resource/class_year'
parseError = require '../../../lib/parse_error'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        errors: {}

    methods:
        performSave: (e)->
            e.preventDefault()

            @cy.$save().then (item)=>
                @$router.go "/admin/class_year/#{item.id}"
                @$toast if @editing then '学年を更新しました' else '学年を追加しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'
    created: ->
        @$resolve
            cy: do =>
                if id = Number @$context().params.id
                    ClassYear.find id: id
                    .then (item)->
                        item.$copy()
                else
                    ClassYear.create
                        year: null


    resolved: ->
        @$watch 'cy.year', (e)=>
            @errors.year = null
