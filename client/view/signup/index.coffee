Vue = require 'vue'

config = require '../../config'
u = require '../../util'

ClassYear = require '../../resource/class_year'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        errors: {}
        user:
            family_name: ''
            given_name: ''
            handle_name: ''
            birthday: ''+((new Date).getFullYear()-19)+'-01-01'
            email: ''
            email_mobile: ''
            class_year_id: null
            password: ''
        reenteredPassword: ''

    computed:
        matchPassword: ->
            @user.password is @reenteredPassword

    validator:
        validates:
            match: (v, result)->
                result
            spaceStartEnd: (v)->
                not /^( |　)|( |　)$/.test v
            mail: (v)->
                not v or u.reg.mail.test v
            hokudaiMail: (v)->
                /^\w+([\.-]?\w+)*@(eis|med)\.hokudai\.ac\.jp$/.test v
    methods:
        performSignup: (e)->
            e.preventDefault()

            @$loader()

            @$http
            .post "#{config.api}/users", @user, =>
                @$router.go '/login'
                @$toast 'ユーザー登録申請を受け付けました'
            .error (data)->
                @errors = parseError data.errors
                @$toast '入力にエラーがあります'
            .always =>
                @$loader false

    created: ->
        @$resolve
            classYears: ClassYear.get()

    resolved: ->
        @user.class_year_id = @classYears[@classYears.length - 1].id


    ready: ->
        @$watch 'user.email', (e)->
            @errors.email = null
        @$watch 'user.handle_name', (e)->
            @errors.handle_name = null
        @$watch 'user.email_mobile', (e)->
            @errors.handle_name = null
