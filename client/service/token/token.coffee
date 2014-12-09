'use strict'

angular.module serviceName

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

    getStorageKey: ->
        storage_key

    setStorageKey: (v)->
        if angular.isString(v) and v isnt ''
            storage_key = v
        else
            throw new Error 'token prefix is to be non-empty string'

    getTokenPrefix: ->
        token_prefix

    setTokenPrefix: (v)->
        if angular.isString(v)
            token_prefix = v
        else
            throw new Error 'token prefix is to be string'

    $get: ($log, $http, store)->
        obj =
            getStorageKey: -> storage_key

            getHeaderKey: -> header_key

            getTokenPrefix: -> token_prefix

            getTokenHeader: ->
                t = @get()
                if t isnt ''
                    if token_prefix is ''
                        return t
                    else
                        return "#{token_prefix} #{t}"
                else
                    return ''

            set: (v)->
                if angular.isString(v) and v isnt ''
                    store.set storage_key, v
                    $http.defaults.headers.common[header_key] = @getTokenHeader()
                else
                    @clear()

            get: ()->
                t = store.get storage_key
                if t? then t else ''

            clear: ()->
                delete $http.defaults.headers.common[header_key]
                store.remove storage_key

        obj.set obj.get()

        obj
