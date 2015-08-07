u = require '../../lib/util'


module.exports = (Vue, options)->

    Vue.component 'model-delete',
        props:
            model:
                type: (require '../../lib/model').Item
                required: true
            next:
                type: String
                required: true
        template: do require './index.jade'
        data: ->
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

                @model.$delete =>
                    @$router.go @next
                    @$toast '削除しました'

        attached: ->
            @code = u.randomString 8
            @confirmedCode = ''
