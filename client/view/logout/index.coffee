Vue = require 'vue'


module.exports = Vue.extend
    template: do require './index.jade'
    methods:
        performLogout: ->
            @$auth.logout()
            Vue.nextTick =>
                @$router.go '/', true
                @$toast 'ログアウトしました。'
