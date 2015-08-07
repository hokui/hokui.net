Vue = require 'vue'

config = require '../../config'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        email: ''
        errors: {}
    methods:
        performResetPassword: (e)->
            console.log 'aa'
            e.preventDefault()

            @$loader()

            @$http
            .post "#{config.api}/password_reset", email: @email, =>
                @$router.go '/login'
                @$toast 'ユーザー登録申請を受け付けました', period: -1
            .error (data)->
                @errors = parseError data.errors
                @$toast '入力にエラーがあります'
            .always =>
                @$loader false

    ready: ->
        @$watch 'email', =>
            @errors.email = null
