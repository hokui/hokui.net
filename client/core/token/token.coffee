'use strict'

angular.module moduleCore

.provider 'Token', class

    header_key = 'Authorization'
    storage_key = 'token'
    token_prefix = 'token'

    constructor: () ->
        # init

    getHeaderKey: ->
        header_key

    setHeaderKey: (v)->
        if angular.isString(v) and v isnt ''
            header_key = v
        else
            throw new Error 'token prefix is to be non-empty string'
        this

    getStorageKey: ->
        storage_key

    setStorageKey: (v)->
        if angular.isString(v) and v isnt ''
            storage_key = v
        else
            throw new Error 'token prefix is to be non-empty string'
        this

    getTokenPrefix: ->
        token_prefix

    setTokenPrefix: (v)->
        if angular.isString(v)
            token_prefix = v
        else
            throw new Error 'token prefix is to be string'
        this

    $get: ($log, $http, webStorage, StorageType)->
        _storage_type = null
        if webStorage.local.isSupported and webStorage.session.isSupported
            if (webStorage.session.get storage_key)?
                _storage_type = StorageType.session
            else
                _storage_type = StorageType.local
        else
            _storage_type =  StorageType.memory

        get_storage = (type)->
            type = StorageType.auto type
            switch type
                when StorageType.session
                    return webStorage.session
                when StorageType.local
                    return webStorage.local
                when StorageType.memory
                    return webStorage.memory
                else
                    return get_storage StorageType.local

        clear_token = (type)->
            get_storage(type).remove storage_key

        gen_header_value = (token)->
            if token isnt ''
                if token_prefix is ''
                    return token
                else
                    return "#{token_prefix} #{token}"
            else
                return ''

        add_header = (token)->
            if h = gen_header_value token
                $http.defaults.headers.common[header_key] = h

        remove_header = ->
            delete $http.defaults.headers.common[header_key]

        Token =
            set: (token, type)->
                if angular.isString(token) and token isnt ''
                    _storage_type = StorageType.auto type
                    get_storage(_storage_type).add storage_key, token
                    add_header token
                else
                    @clear()

            get: ->
                t = get_storage(_storage_type).get storage_key
                if t? then t else ''

            empty: ->
                @get() isnt ''

            clear: ()->
                remove_header()
                for t in StorageType.all()
                    get_storage(t).remove storage_key

        add_header Token.get()

        Token


