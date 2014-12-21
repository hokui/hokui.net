'use strict'

angular.module moduleCore

.provider 'Env', ->
    _dev = false
    _seed = {}
    _api_path = ''

    setDev: (d)->
        _dev = !!d
        this

    setApiPath: (api)->
        _api_path = api
        this

    setSeed: (key, value)->
        if angular.isString key
            _seed[key] = value
        else
            throw new Exception '"key" must be String'
        this

    $get: ($injector)->
        if not _api_path
            throw new Error 'API path is not configured.'

        _api_path = do ->
            if angular.isFunction _api_path
                return _api_path $injector
            else
                return '' + _api_path

        dev: _dev
        seed: (key)->
            if _seed[key]?
                return angular.copy _seed[key]
            else
                return null
        apiPath: ->
            _api_path





