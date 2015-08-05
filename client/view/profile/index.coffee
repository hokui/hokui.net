Vue = require 'vue'

parseError = require '../../lib/parse_error'
setting = require '../../lib/setting'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        errors: {}
        user: Vue.auth.user true
        useTargetBlank: setting.useTargetBlank.get()
    validator:
        validates:
            sapceStartEnd: (v)->
                not /^( |　)|( |　)$/.test v


    methods:
        performSave: (e)->
            e.preventDefault()

            @$loader()

            @$auth.update @user
            .always =>
                @$loader false
            .then =>
                setting.useTargetBlank.set @useTargetBlank
                @$toast 'プロフィールを更新しました'
            , (res)=>
                @errors = parseError res.data.errors
                @$toast '更新に失敗しました'

    ready: ->
        @$watch 'user.handle_name', (e)->
            @errors.handle_name = null
