'use strict'

angular.module moduleCore

.provider 'Auth', ->
    $get: ($http, $q, Token, Env) ->
        api = Env.apiRoot()

        _current =
            user : null

        _levels =
            admin: 2
            user: 1
            guest: 0

        level: ->
            if @admin()
                return _levels.admin
            if @active()
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
            Token.exists() and _current.user?

        user: ->
            _current.user

        admin: ->
            @active() and !!_current.user.admin and _current.user.admin

        login: (credencials, keepLogin)->
            deferred = $q.defer()
            $http.post "#{api}/session",
                email: credencials.email
                password: credencials.password
            .success (data)=>
                Token.set data.token, keepLogin? and keepLogin
                _current.user = data.user
                deferred.resolve _current
            .error (err)=>
                @silentLogout()
                deferred.reject err

            deferred.promise

        logout: ->
            deferred = $q.defer()
            _finally = (data)=>
                @silentLogout()
                deferred.resolve()

            if Token.exists()
                $http.delete "#{api}/session", {}
                .success _finally
                .error _finally
            else
                _finally()

            deferred.promise

        silentLogout: ()->
            Token.clear()
            _current.user = null


        check: ->
            deferred = $q.defer()
            if Token.exists()
                $http.get "#{api}/profile", {}
                .success (data)=>
                    _current.user = data
                    deferred.resolve _current
                .error (err)=>
                    @silentLogout()
                    deferred.reject _current
            else
                @silentLogout()
                deferred.reject _current
            deferred.promise

.provider 'AutoAuthCheck', ->
    _enabled = false
    _defaultAltStateChangeStart = '$stateChangeStartAuthChecked'
    _altStateChangeStart = _defaultAltStateChangeStart

    use: (u)->
        _enabled = u

    defaultAltStateChangeStart: ()-> _defaultStateChangeStart

    setAltStateChangeStart: (s)->
        if angular.isString s
            _altStateChangeStart = s
        else
            throw new Error "Needs to be String. You provided #{s}"

    $get: ($rootScope, $state, Auth)->
        status =
            resolved: false
            altStateChangeStart: _altStateChangeStart

        if _enabled
            unregister = $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
                go = ->
                    status.resolved = true
                    $state.transitionTo toState, toParams

                Auth.check().then go, go
                ev.preventDefault()
                unregister()
        else
            status.resolved = true

        $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
            if not status.resolved
                return
            $rootScope.$broadcast _altStateChangeStart, ev, toState, toParams, fromState, fromParams

        status




