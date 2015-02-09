'use strict'

angular.module moduleCore

.provider 'Token', ->

    _header_key = 'Authorization'
    _storage_key = 'token'
    _token_prefix = 'token'

    getHeaderKey: ->
        _header_key

    setHeaderKey: (v)->
        if _.isString(v) and v isnt ''
            _header_key = v
        else
            throw new Error 'token prefix is to be non-empty string'
        this

    getStorageKey: ->
        _storage_key

    setStorageKey: (v)->
        if _.isString(v) and v isnt ''
            _storage_key = v
        else
            throw new Error 'token prefix is to be non-empty string'
        this

    getTokenPrefix: ->
        _token_prefix

    setTokenPrefix: (v)->
        if _.isString(v)
            _token_prefix = v
        else
            throw new Error 'token prefix is to be string'
        this

    $get: ($log, $http, webStorage)->
        _storage = do ->
            if webStorage.local.isSupported and webStorage.session.isSupported
                if (webStorage.session.get _storage_key)?
                    return webStorage.session
                else
                    return webStorage.local
            else
                return StorageType.memory

        add_header = (token)->
            if not token
                return
            $http.defaults.headers.common[_header_key] =
                if _token_prefix is '' then token else "#{_token_prefix} #{token}"

        Token =
            set: (token, keep)->
                if _.isString(token) and token isnt ''
                    _storage = do ->
                        if not keep?
                            return webStorage.memory
                        if webStorage.local.isSupported and keep
                            return webStorage.local
                        if webStorage.session.isSupported
                            return webStorage.session
                        else
                            return webStorage.memory
                    _storage.add _storage_key, token
                    add_header token
                else
                    @clear()

            get: ->
                t = _storage.get _storage_key
                if t? then t else ''

            exists: ->
                @get() isnt ''

            clear: ()->
                delete $http.defaults.headers.common[_header_key]
                for storage in [webStorage.session, webStorage.local, webStorage.memory]
                    storage.remove _storage_key

        add_header Token.get()

        Token


