Vue = require 'vue'

Subject = require '../../../resource/subject'
u = require '../../../lib/util'


module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        resolved: false
        subject: null
        viewMode: 'detail'

        code: ''
        confirmedCode: ''

    computed:
        matchCode: ->
            @code is @confirmedCode
    validator:
        validates:
            match: (v, result)->
                result
    methods:
        performDelete: (e)->
            e.preventDefault()

            @subject.$delete =>
                @$router.go '/admin/class_year'
                @$toast '削除しました'


    ready: ->

        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode

            @code = u.randomString 8
            @confirmedCode = ''

            Subject.find id: (Number @$context().params.id), (item)=>
                @resolved = true
                @subject = item
