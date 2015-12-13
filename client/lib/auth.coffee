config = require '../config'
u = require '../util'

api = config.api

module.exports = (Vue)->
    user = null

    setUser = (u)->
        user = u

    auth =
        level: ->
            if user?
                if user.admin
                    return 0b100
                else
                    return 0b010
            else
                return 0b001
        can: (rule)->
            if not Number.isInteger rule
                rule = 0b111
            !!(rule & @level())

        active: -> user?
        user: (copy)->
            if copy? and copy
                u.extend {}, user,  true
            else
                user
        admin: ->
            !!(user and user.admin)
        check: ->
            Vue.http
            .get "#{api}/profile", (data)->
                setUser data
            .error =>
                @silentLogout()

        login: (credentials, keepLogin)->
            Vue.http
            .post "#{api}/session", credentials, (data)->
                Vue.token.set data.token, keepLogin
                setUser data.user
            .error =>
                @silentLogout()

        update: (newUser)->
            Vue.http
            .put "#{api}/profile", newUser, (data)->
                setUser data

        silentLogout: ->
            user = null
            Vue.token.clear()

        logout: ->
            if Vue.token.exists()
                Vue.http
                .delete "#{api}/session"
            @silentLogout()

    Vue.auth = Vue.prototype.$auth = auth
