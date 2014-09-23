'use strict'

angular.module appName
.provider 'Token', class

    constructor: () ->
        # init
    token_key = 'Authorization'
    storage_key = 'token'
    token_prefix = ''

    tokenKey: (tk)->
        if tk?
            if tk isnt ''
                token_key = tk
            else
                throw 'tokenKey mustnt be empty'
        token_key

    storageKey: (sk)->
        if sk?
            if sk isnt ''
                storage_key = sk
            else
                throw 'storageKey mustnt be empty'
        storage_key

    tokenPrefix: (tp)->
        if tp?
            token_prefix = tp
        token_prefix

    $get: ($log, $http, storage)->
        if token_prefix
            appending = token_prefix + ' '
        else
            appending = ''

        token = storage.get(storage_key)

        if token?
            $http.defaults.headers.common[token_key] = "#{appending}#{token}"

        set: (t)->
            if t?
                token = t
                $http.defaults.headers.common[token_key] = "#{appending}#{token}"
                storage.set(storage_key, t)
            else
                @clear()
                $log.info('Called Token.set(token) with nil token, token is automatically cleared')
        get: ()->
            token
        clear: ()->
            token = ''
            storage.remove(storage_key)
            delete $http.defaults.headers.common[token_key]


.config (TokenProvider)->
    TokenProvider.tokenKey 'Access-Token'
    TokenProvider.storageKey 'token'
    TokenProvider.tokenPrefix ''

