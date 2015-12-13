config = require '../config'

fillDefault = (base, def)->
    for k in Object.keys base
        if not def.hasOwnProperty k
            delete base[k]

    for k, v of def
        if not base[k]?
            base[k] = v
            continue

        if typeof v is 'object'
            if typeof base[k] is 'object'
                fillDefault base[k], v
            else
                base[k] = v

class Item
    constructor: (@store, @name, @defaultValue)->
        @store[@name] = this
        s = @get()
        if not s?
            @set @defaultValue
        else
            if typeof @defaultValue is 'object'
                if typeof s is 'object'
                    fillDefault s, @defaultValue
                    @set s

    set: (v)->
        s = @store.$get()
        s[@name] = v
        @store.$set(s)
    get: ->
        @store.$get()[@name]


class Store
    constructor: (@$storage, @$key)->
        if str = @$storage.getItem @$key
            try
                JSON.parse str
            catch
                @$reset()
        else
            @$reset()

    $get: ->
        JSON.parse @$storage.getItem @$key

    $set: (s)->
        @$storage.setItem @$key, JSON.stringify s
    $reset: ->
        @$set {}

    $trim: ->
        s = @$get()
        s2 = {}
        for k, v of s
            if (not /^\$/.test k) and this[k]
                s2[k] = v
        @$set s2

    $add: (name, defaultValue)->
        if /^\$/.test name
            throw new Error "Do not use `$` starting name. (#{@name})"
        new Item this, name, defaultValue

module.exports =
    local: new Store localStorage, config.storeStorageKey
    session: new Store sessionStorage, config.storeStorageKey
