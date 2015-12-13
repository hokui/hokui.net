Vue = require 'vue'

ClassYear = require '../../resource/class_year'

parseError = require '../../lib/parse_error'
u = require '../../lib/util'


module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        errors: {}
        user: @$auth.user true

    validator:
        validates:
            sapceStartEnd: (v)->
                not /^( |　)|( |　)$/.test v
            mail: (v)->
                not v or u.reg.mail.test v

    methods:
        performSaveProfile: (e)->
            e.preventDefault()

            @$loader()

            @$auth.update @user
            .always =>
                @$loader false
            .then (user)=>
                @user = @$auth.user true
                @$router.go '/profile', true
                @$toast 'プロフィールを更新しました'
            , (res)=>
                @errors = parseError res.data.errors
                @$toast '更新に失敗しました'


    created: ->
        @$resolve
            classYears: ClassYear.get()

    ready: ->
        @$watch 'user.handle_name', (e)->
            @errors.handle_name = null
