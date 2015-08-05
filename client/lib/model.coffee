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


class ModelItem
    constructor: (base, model)->
        Object.defineProperty this, 'model', value: model
        extend this, base

    $copy: ->
        new ModelItem this, @model

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
            .error err_cb
        else
            @model.__resource.save {}, this, handler
            .error err_cb

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
        .error ->
            error_cb?()

class Model
    __resource: null
    __pks: {}
    __items: null
    __updated: false
    __pending: null
    __sorters: {}
    __filters: {}

    constructor: (url)->
        @url = url
        @__resource = Vue.resource config.api + url
        for m in url.match /(:.+?(:|\/|\.))|(:.+$)/g
            m = m
            .replace ':', ''
            .replace '.', ''
            .replace '/', ''
            if m
                @__pks[m] = true

    fetch: (cb)->
        if not @__pending
            @__pending = new Promise (resolve, reject)=>
                @__resource.get (items)=>
                    @__items = []
                    for item in items
                        @__items.push new ModelItem item, this
                    @__updated = false
                    @__pending = null
                    resolve()
                .error reject

        @__pending.then =>
            cb()

    get: (cb)->
        if not @__items or @__updated
            @fetch =>
                cb @__items
        else
            new Promise (resolve)=>
                resolve()
                cb @__items

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

    addSorter: (name, sorter)->
        @__sorters[name] = sorter

    addFilter: (name, f)->
        @__filters[name] = f


    retrieve: (search,  multiple)->
        if not @__items
            console.warn 'Items are not fetched'
            return null

        found = false
        if multiple? and multiple
            result = []
        else
            result = null
        for item in @__items
            for k, v of search
                if item[k] is v
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

    create: (scheme)->
        new ModelItem scheme, this


module.exports = Model
