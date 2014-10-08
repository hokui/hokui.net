'use strict'

angular.module serviceName

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
                throw new Error('tokenKey mustnt be empty')
        token_key

    storageKey: (sk)->
        if sk?
            if sk isnt ''
                storage_key = sk
            else
                throw new Error('storageKey mustnt be empty')
        storage_key

    tokenPrefix: (tp)->
        if tp?
            token_prefix = tp

        token_prefix

    $get: ($log, $http, storage)->

        token = storage.get(storage_key)

        obj =
            storageKey: ->
                storage_key

            tokenKey: ->
                token_key

            tokenPrefix: ->
                token_prefix

            setToStorage: ->
                storage.set(storage_key, token)

            tokenHeader: ->
                if token isnt ''
                    if token_prefix is ''
                        return token
                    else
                        return "#{token_prefix} #{token}"
                else
                    return ''

            set: (t, useStorage)->
                if (t?)and(t isnt '')
                    if not useStorage?
                        useStorage = true
                    token = '' + t
                    if useStorage
                        @setToStorage()
                    $http.defaults.headers.common[token_key] = @tokenHeader()
                else
                    @clear()

            get: ()->
                token

            clear: ()->
                token = ''
                storage.remove(storage_key)
                delete $http.defaults.headers.common[token_key]

        obj.set token

        obj

