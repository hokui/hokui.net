Vue = require 'vue'
config = require '../config'

extend = (a, b, copy)->
    target = if copy then (extend {}, a, false) else a
    for k, v of b
        target[k] = v
    target

copy = (arr)->
    c = new Array arr.length
    for i, v of arr
        c[i] = v


class Item
    constructor: (base, model)->
        Object.defineProperty this, 'model', value: model
        extend this, base

    $copy: ->
        @model.create this

    $save: (cb, err_cb)->
        param = {}
        updating = false
        for pk of @model.__pks
            if this[pk]?
                param[pk] = this[pk]
                updating = true

        handler = (data)=>
            extend this, data
            if updating
                overwrited = false
                for i, v of @model.__items
                    if v.id is this.id
                        @model.__items[i] = this
                        overwrited = true
                        break
                if not overwrited
                    @model.__updated = true
            else
                @model.__items.push this
            cb this

        if updating
            @model.__resource.update param, this, handler
            .error -> err_cb?()
        else
            @model.__resource.save {}, this, handler
            .error -> err_cb?()

    $delete: (cb, err_cb)->
        has_pk = false
        param = {}
        for pk of @model.__pks
            if this[pk]?
                param[pk] = this[pk]
                has_pk = true
        if not has_pk
            console.warn 'The resource has no primary key field', this
            cb null
            return

        @model.__resource.delete param, this, =>
            idx = @model.__items.indexOf this
            if idx > -1
                @model.__items.splice idx, 1
            else
                @model.__updated = true
            cb()
        .error -> error_cb?()

class Model
    Item: Item

    constructor: (url)->
        @url = url
        @__items = null
        @__updated = false
        @__pending = null
        @__sorters = {}
        @__filters = {}

        @__resource = Vue.resource config.api + url

        @__pks = {}
        for m in url.match /(:.+?(:|\/|\.))|(:.+$)/g
            m = m
            .replace ':', ''
            .replace '.', ''
            .replace '/', ''
            if m
                @__pks[m] = true

    fetch: ->
        if not @__pending
            @__pending = new Promise (resolve, reject)=>
                @__resource.get (items)=>
                    @__items = []
                    for item in items
                        @__items.push new @Item item, this
                    @__updated = false
                    @__pending = null
                    resolve @__items
                .error ->
                    resolve null

        @__pending

    get: (cb)->
        if not @__items or @__updated
            @fetch().then =>
                cb? @__items
                @__items
        else
            new Promise (resolve)=>
                cb? @__items
                resolve @__items

    transformed: (param, cb)->
        @get =>
            transformed = copy @__items
            p = param || {}
            if typeof p.filter is 'object'
                for name, value of p.filter
                    if filter = @__filters[name]
                        transformed = transformed.filter filter(value)

            if sorter = @__sorters[p.sort]
                transformed.sort sorter
            if p.inverted
                transformed.reverse()
            cb transformed

    # SYNCHRONOUS
    addSorter: (name, sorter)->
        @__sorters[name] = sorter

    # SYNCHRONOUS
    addFilter: (name, f)->
        @__filters[name] = f

    # SYNCHRONOUS
    retrieve: (search,  multiple)->
        if not @__items
            console.warn 'Items are not fetched'
            return null

        match = (v, item)->
            if Array.isArray v
                (v.indexOf item[k]) > -1
            else
                item[k] is v

        found = false
        if multiple? and multiple
            result = []
        else
            result = null
        for item in @__items
            for k, v of search
                if match v, item
                    if multiple
                        result.push item
                    else
                        result = item
                        break
        result

    find: (search, cb, multiple)->
        if not @__items or @__updated
            @fetch =>
                cb @retrieve search, multiple
            return

        cb @retrieve search, multiple

    # SYNCHRONOUS
    create: (base)->
        new @Item base, this


module.exports = Model
