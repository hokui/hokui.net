'use strict'

angular.module @serviceName

.factory 'Auth', ($http, $q, Token) ->
        _current =
            active: false
            user : {}

        _levels =
            admin: 2
            user: 1
            guest: 0

        level: ->
            if _current.active and _current.user?
                if _current.user.admin
                    return _levels.admin
                else
                    return _levels.user
            else
                return _levels.guest

        can : (role_or_level)->
            if role_or_level?
                if typeof role_or_level isnt 'number'
                    needs_level = _levels[role_or_level] or 0
                else
                    needs_level = role_or_level
            else
                needs_level = _levels.user

            _can = needs_level <= @level()
            return _can


        active: ->
            _current.active

        user: ->
            _current.user

        login: (user) ->
            deferred = $q.defer()
            $http.post '/api/session',
                email: user.email
                password: user.password
            .success (data) =>
                Token.set(data.token)
                _current.active = true
                _current.user = data.user
                deferred.resolve _current
            .error (err) ->
                deferred.reject err

            deferred.promise

        logout: (callback) ->
            deferred = $q.defer()
            if Token.get()
                $http.delete '/api/session', {}
                .success (data) =>
                    @silentLogout()
                    deferred.resolve()

            else
                @silentLogout()
                deferred.resolve()

            deferred.promise

        silentLogout: ()->
            Token.clear()
            _current.active = false
            _current.user = {}


        check: (callback) ->
            deferred = $q.defer()
            if Token.get()
                $http.get '/api/users/profile', {}
                .success (data) =>
                    _current.active = true
                    _current.user = data
                    deferred.resolve _current
                .error (err) =>
                    deferred.reject _current

            else
                @silentLogout()
                deferred.reject _current

            deferred.promise

