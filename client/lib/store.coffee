config = require '../config'

class Item
    constructor: (@store, @name, @defaultValue)->
        @store[@name] = this
        if not @get()?
            @set @defaultValue

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
