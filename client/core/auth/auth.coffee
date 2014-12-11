'use strict'

angular.module moduleCore

.provider 'Auth', ->
    _conf =
        events:
           userUpdated: 'AUTH:USER_UPDATED'

    $get: ($http, $q, $rootScope, Token, StorageType) ->
        _current =
            user : null

        _levels =
            admin: 2
            user: 1
            guest: 0

        broadcastUserUpdated = ->
            $rootScope.$broadcast _conf.events.userUpdated, _current.user

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
            !!Token.get() and _current.user isnt null

        user: ->
            _current.user

        admin: ->
            Token.get() and _current.user?.admin? and _current.user.admin

        login: (user, keepLoging)->
            deferred = $q.defer()
            $http.post '/api/session',
                email: user.email
                password: user.password
            .success (data)=>
                if not keepLoging?
                    throw new Error 'Need to set param:keepLoging'
                Token.set data.token, if keepLoging then StorageType.local else StorageType.session
                _current.user = data.user
                deferred.resolve _current
                broadcastUserUpdated()
            .error (err)=>
                @silentLogout()
                deferred.reject err
                broadcastUserUpdated()

            deferred.promise

        logout: (callback)->
            deferred = $q.defer()
            t = Token.get()
            _finally = (data)=>
                @silentLogout()
                deferred.resolve()
                broadcastUserUpdated()

            if t? and t isnt ''
                $http.delete '/api/session', {}
                .success _finally
                .error _finally
            else
                _finally()

            deferred.promise

        silentLogout: ()->
            Token.clear()
            _current.user = null


        check: (callback)->
            deferred = $q.defer()
            t = Token.get()
            if t? and t isnt ''
                $http.get '/api/users/profile', {}
                .success (data)=>
                    _current.user = data
                    deferred.resolve _current
                    broadcastUserUpdated()
                .error (err)=>
                    @silentLogout()
                    deferred.reject _current
                    broadcastUserUpdated()
            else
                @silentLogout()
                deferred.reject _current
                broadcastUserUpdated()
            deferred.promise



