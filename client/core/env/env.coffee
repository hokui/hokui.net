'use strict'

angular.module moduleCore

.provider 'Env', ->
    _dev = false
    _seed = {}
    _api_root = '/api'

    setDev: (d)->
        _dev = !!d
        this

    setApiRoot: (api)->
        _api_root = api
        this

    setSeed: (key, value)->
        _seed[key] = _.clone value
        this

    $get: ->
        dev: -> _dev
        seed: (key)-> if _seed[key]? then _seed[key] else null
        apiRoot: -> _api_root
