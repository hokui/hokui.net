'use strict'

angular.module moduleCore

.provider 'Env', ->
    _dev = false
    _seed = {}
    _api_root = ''

    setDev: (d)->
        _dev = !!d
        this

    setApiRoot: (api)->
        _api_root = api
        this

    setSeed: (key, value)->
        if angular.isString key
            _seed[key] = value
        else
            throw new Exception '"key" must be String'
        this

    $get: ($injector)->
        if not _api_root
            throw new Error 'API path is not configured.'

        _api_root = do ->
            if angular.isFunction _api_root
                return _api_root $injector
            else
                return '' + _api_root

        dev: _dev
        seed: (key)->
            if _seed[key]?
                return angular.copy _seed[key]
            else
                return null
        apiRoot: ->
            _api_root





