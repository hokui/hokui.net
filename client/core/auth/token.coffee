'use strict'

angular.module moduleCore

.provider 'Token', ->

    _default_header_key = 'Authorization'
    _default_storage_key = 'token'
    _default_token_prefix = 'token'

    _header_key = _default_header_key
    _storage_key = _default_storage_key
    _token_prefix = _default_token_prefix

    getHeaderKey: ->
        _header_key

    setHeaderKey: (v)->
        _header_key = v
        this

    getStorageKey: ->
        _storage_key

    setStorageKey: (v)->
        _storage_key = v
        this

    getTokenPrefix: ->
        _token_prefix

    setTokenPrefix: (v)->
        _token_prefix = v
        this

    $get: ($log, $http, webStorage)->
        if not _.isString(_header_key) or not _header_key
            _header_key = _default_header_key

        if not _.isString(_storage_key) or not _storage_key
            _storage_key = _default_storage_key

        if not _.isString(_token_prefix)
            _token_prefix = _default_token_prefix

        _current_storage = do ->
            l = webStorage.local.isSupported
            s = webStorage.session.isSupported
            if l and s
                if (webStorage.session.get _storage_key)?
                    return webStorage.session
                else
                    return webStorage.local
            if l
                return webStorage.local
            if s
                return webStorage.session

            return webStorage.memory

        add_header = (token)->
            if not token
                return
            $http.defaults.headers.common[_header_key] =
                if _token_prefix is '' then token else "#{_token_prefix} #{token}"

        clear_token = ->
            delete $http.defaults.headers.common[_header_key]
            for storage in [webStorage.session, webStorage.local, webStorage.memory]
                storage.remove _storage_key

        set_token = (token, keep)->
            if _.isString(token) and token isnt ''
                _current_storage = do ->
                    l = webStorage.local.isSupported
                    s = webStorage.session.isSupported
                    if keep
                        if l
                            return webStorage.local
                        else
                            if s
                                return webStorage.session
                            else
                                return webStorage.memory
                    else
                        if s
                            return webStorage.session
                        else
                            return webStorage.memory

                _current_storage.add _storage_key, token
                add_header token
            else
                clear_token()

        get_token = ->
            t = _current_storage.get _storage_key
            if t? then t else ''


        add_header get_token()


        clear: clear_token
        set: set_token
        get: get_token
        exists: ->
            get_token() isnt ''

        empty: ->
            get_token() is ''
        getHeaderKey: ->
            _header_key
        getStorageKey: ->
            _storage_key
        getTokenPrefix: ->
            _token_prefix
