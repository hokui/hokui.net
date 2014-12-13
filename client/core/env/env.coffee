'use strict'

angular.module moduleCore

.provider 'Env', ->
    _dev = false
    _seed = {}

    setDev: (d)->
        _dev = !!d
        this

    setSeed: (key, value)->
        if angular.isString key
            _seed[key] = value
        else
            throw new Exception '"key" must be String'
        this

    $get: ->
        dev: _dev
        seed: (key)->
            if _seed[key]?
                return angular.copy _seed[key]
            else
                return null




