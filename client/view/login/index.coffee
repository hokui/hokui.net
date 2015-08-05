Vue = require 'vue'

config = require '../../config'
setting = require '../../lib/setting'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        fakeValue: false
        active: Vue.auth.active()
        credentials:
            email: ''
            password: ''
        keepLogin: false
    methods:
        performLogin: (e)->
            e.preventDefault()
            if @invalid
                @$toast '入力に不備があります'
                return

            @$loader()
            @$auth.login @credentials, @keepLogin
            .then =>
                setting.signupRequested.set false
                @$toast 'ようこそ、北医ネットへ！'
                @$router.go '/', true
            , =>
                @$toast 'メールアドレスもしくはパスワードが間違っています'
                @$loader false
