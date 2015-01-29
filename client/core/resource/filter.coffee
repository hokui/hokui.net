'use strict'

angular.module moduleCore

.factory 'ResourceFilter', ->
    class
        constructor: (params)->
            if angular.isObject params
                @label = params.label
                @slug = params.slug
                @prepare = params.prepare
            @active = false
            @items = []
        search: -> true

.factory 'ResourceFilterGroup', (ResourceFilter)->
    class extends ResourceFilter
        constructor: (params)->
            super params
            @items = []
        add: (item)->
            @items.push item
            this

        search: (model)=>
            for item in @items
                if not item.search model
                    return false
            true

.factory 'ResourceFilterItem', (ResourceFilter)->
    class extends ResourceFilter

        constructor: (params)->
            super params
            if angular.isObject params
                @search = params.search

        @valueFilter: (key, label)->
            item = new ResourceFilterItem label, (model)->
                if model[key] and item.value
                    return model[key] is item.value
                else
                    return true
            item


.factory 'ResourceFilterItems', (ResourceFilterGroup, ResourceFilterItem)->
    class extends ResourceFilterGroup
        constructor: (params)->
            super params
            @multiple = false
            if angular.isObject params
                if params.multiple?
                    @multiple = multiple

            showAll = new ResourceFilterItem
                label: 'すべて表示'
                search: -> true
            showAll.active = true
            @add showAll


        select: (current)->
            if not @multiple
                for item in @items
                    item.active = false
            current.active = true

        get: (slug)->
            for item in @items
                if slug is item.slug
                    return item
            null

        selectBySlug: (slug)->
            item = @get slug
            if item
                @select item

        addItem: (params)->
            item = new ResourceFilterItem params
            @add item
            this

        search: (model)=>
            for item in @items
                if (item.active or not item.active?) and not item.search model
                    return false
            true

