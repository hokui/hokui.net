'use strict'

angular.module moduleCore

.provider 'Token', ->

    _default_header_key = 'Authorization'
    _default_storage_key = 'token'
    _default_token_prefix = 'token'

    headerKey: (header_key)->
        if (_.isString header_key) and header_key
            _default_header_key = header_key
        _default_header_key

    storageKey: (storage_key)->
        if (_.isString storage_key) and storage_key
            _default_storage_key = storage_key
        _default_storage_key

    tokenPrefix: (token_prefix)->
        if _.isString token_prefix
            _default_token_prefix = token_prefix
        _default_token_prefix

    $get: ($log, $http, webStorage)->
        _header_key = _default_header_key
        _storage_key = _default_storage_key
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
        headerKey: ->
            _header_key
        storageKey: ->
            _storage_key
        tokenPrefix: ->
            _token_prefix
