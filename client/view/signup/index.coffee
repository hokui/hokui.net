Vue = require 'vue'

config = require '../../config'

parseError = require '../../lib/parse_error'
signupRequested = (require '../../lib/store').local.signupRequested

ClassYear = require '../../resource/class_year'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        errors: {}
        classYears: null
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
        signupRequested: signupRequested.get()

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
                not v or /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test v
            hokudaiMail: (v)->
                /^\w+([\.-]?\w+)*@(eis|med)\.hokudai\.ac\.jp$/.test v
    methods:
        performSignup: (e)->
            e.preventDefault()

            @$loader()

            @$http
            .post "#{config.api}/users", @user, =>
                @signupRequested.set true
                @$router.go '/login'
                @$toast 'ユーザー登録申請を受け付けました'
            .error (data)->
                @errors = parseError data.errors
                @$toast '入力にエラーがあります'
            .always =>
                @$loader false


    ready: ->
        @$watch 'user.email', (e)->
            @errors.email = null
        @$watch 'user.handle_name', (e)->
            @errors.handle_name = null
        @$watch 'user.email_mobile', (e)->
            @errors.handle_name = null

        @$loader()

        ClassYear.get (items)=>
            @$loader false
            if items
                @classYears = items
                @user.class_year_id = @classYears[@classYears.length - 1].id
            else
                @$router.go '/login'
                @$toast 'DB error'
