Vue = require 'vue'
config = require '../config'

u = require './util'


class Item
    constructor: (base, model)->
        Object.defineProperty this, 'model', value: model
        u.extend this, base

    $copy: ->
        @model.create this

    $save: ->
        param = {}
        updating = false
        for pk of @model.__pks
            if this[pk]?
                param[pk] = this[pk]
                updating = true

        new Promise (resolve, reject)=>

            handler = (data)=>
                u.extend this, data
                if @model.__items
                    if updating
                        overwrited = false
                        for i, v of @model.__items
                            if v.id is this.id
                                console.log 'over wrote'
                                @model.__items[i] = this
                                overwrited = true
                                break
                        if not overwrited
                            @model.__updated = true
                    else
                        @model.__items.push this
                resolve this

            if updating
                promise = @model.__resource.update param, this, handler
                .error reject
            else
                promise = @model.__resource.save {}, this, handler
                .error reject



    $delete: ->
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

        .then (->), (err)->
            throw err.data


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
                    reject null

        @__pending

    get: ->
        if not @__items or @__updated
            @fetch().then =>
                @__items
        else
            new Promise (resolve)=>
                if @__items
                    resolve @__items
                else
                    reject null

    transformed: (param)->
        @get().then =>
            transformed = u.copy @__items
            p = param || {}
            if typeof p.filter is 'object'
                for name, value of p.filter
                    if filter = @__filters[name]
                        transformed = transformed.filter filter(value)

            if sorter = @__sorters[p.sort]
                transformed.sort sorter
            if p.inverted
                transformed.reverse()
            transformed

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

    find: (search, multiple)->
        @get().then =>
            new Promise (resolve, reject)=>
                item = @retrieve search, multiple
                if item
                    resolve item
                else
                    reject null


    # SYNCHRONOUS
    create: (base)->
        new @Item base, this

module.exports = Model
