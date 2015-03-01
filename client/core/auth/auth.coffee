'use strict'

angular.module moduleCore

.factory 'Auth', ($http, $q, Token, Env) ->
    _apiRoot = Env.apiRoot()

    _current =
        user : null

    _levels =
        admin: 2
        user: 1
        guest: 0

    _notifier = $q.defer()

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
        $http.post "#{_apiRoot}/session",
            email: credencials.email
            password: credencials.password
        .success (data)=>
            Token.set data.token, keepLogin? and keepLogin
            _current.user = data.user
            deferred.resolve _current
            _notifier.notify true
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
            $http.delete "#{_apiRoot}/session", {}
            .success _finally
            .error _finally
        else
            _finally()

        deferred.promise

    silentLogout: ()->
        _notifier.notify false
        Token.clear()
        _current.user = null

    check: ->
        deferred = $q.defer()
        if Token.exists()
            $http.get "#{_apiRoot}/profile", {}
            .success (data)=>
                _current.user = data
                deferred.resolve _current
                _notifier.notify true
            .error (err)=>
                @silentLogout()
                deferred.reject _current
        else
            @silentLogout()
            deferred.reject _current
        deferred.promise

    on: (ev)->
        _notifier.promise.then (->), (->), ev


.provider 'AuthChecker', ->
    _defaultAltStateChangeStart = '$stateChangeStartAuthChecked'
    _altStateChangeStart = _defaultAltStateChangeStart
    _enabled = false

    enabled: (flag)->
        if flag?
            _enabled = !!flag
        _enabled

    defaultAltStateChangeStart: ->
        _defaultAltStateChangeStart

    setAltStateChangeStart: (s)->
        _altStateChangeStart = s

    getAltStateChangeStart: ->
        _altStateChangeStart

    $get: ($rootScope, $state, Auth)->
        if _enabled
            _resolved = false

            $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)=>
                if _resolved
                    result = $rootScope.$broadcast _altStateChangeStart, toState, toParams, fromState, fromParams
                    if result.defaultPrevented
                        ev.preventDefault()
                    return

                go = (r)=>
                    _resolved = true
                    $state.transitionTo toState.name, toParams
                Auth.check().then go, go
                ev.preventDefault()

        enabled: ->
            _enabled

        altStateChangeStart: ->
            _altStateChangeStart


