config = require '../config'
token = require './token'

UserModel = require '../resource/user'

user = null

extend = (a, b, copy)->
    target = if copy then (extend {}, a, false) else a
    for k, v of b
        target[k] = v
    target


setUser = (u)->
    UserModel.__updated = true
    user = u

module.exports = (Vue)->
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
                extend {}, user,  true
            else
                user
        admin: ->
            !!(user and user.admin)
        check: ->
            Vue.http
            .get "#{config.api}/profile", (data)->
                setUser data
            .error ->
                user = null

        login: (credentials, keepLogin)->
            Vue.http
            .post "#{config.api}/session", credentials, (data)->
                token.set data.token, keepLogin
                setUser data.user
            .error ->
                user = null

        update: (newUser)->
            Vue.http
            .put "#{config.api}/profile", newUser, (data)->
                setUser data

        logout: ->
            if token.exists()
                Vue.http
                .delete "#{config.api}/session"
            user = null
            token.clear()

    Vue.auth = auth
    Vue.prototype.$auth = auth
