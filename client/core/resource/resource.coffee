'use strict'

angular.module moduleCore

.factory 'ResourceFilter', ->
    class ResourceFilter
        constructor: (params)->
            @_parent = null
            @_active = true
            @_children = []

            default_params =
                label: ''
                alternative: false
                slug: null
                value: null
                filter: @filter
                parent: null

            p = if _.isObject params then _.assign default_params, params else default_params

            @label = p.label
            @slug = p.slug
            @value = p.value
            @filter = p.filter
            @alternative = !!p.alternative
            @_parent = p.parent

            if @alternative
                @_active = false

            if @_parent
                @_parent.append this

        append: (child)->
            child._parent = this
            if @alternative
                child._active = false
            @_children.push child

            this

        findBySlug: (slug)->
            _.find @_children, (child)->
                child.slug is slug

        children: ->
            @_children

        active: (flag)->
            if flag?
                @_active = flag = !!flag
                if @alternative
                    if flag
                    else
                        for child in @_children
                            child._active = false

                if @_parent?.alternative
                    for child in @_parent._children
                        if child isnt this
                            child._active = false

                    @_parent._active = flag

            return @_active

        filter: (resource)->
            for child in @_children
                if child._active
                    if not child.filter resource
                        return false
            return true

.factory 'ResourceSorter', ->
    class ResourceSorter
        constructor: (sortFunc)->
            if _.isFunction sortFunc
                @_sortFunc = sortFunc
            else
                @_sortFunc = (a, b)->
                    a.id > b.id

        sort: (list)->
            sorted = _.clone list
            sorted.sort @_sortFunc
            sorted

.factory 'ResourceFieldSorter', (ResourceSorter)->
    class ResourceSorter extends ResourceSorter
        constructor: (keys)->
            super (a, b)->
                for key in keys
                    A = a[key]
                    B = b[key]
                    if A is B
                        continue
                    if _.isString(A) and _.isString(B)
                        diff = A.localeCompare B
                    else
                        diff = A - B

                    if diff isnt 0
                        return diff
            0

.factory 'ResourceStore', (ResourceSorter)->
    class ResourceStore
        constructor: (original)->
            if _.isArray original
                @original = original
            else
                throw new Error 'resources is to be Array'

            @_inverted = false

        count: ->
            @original.length

        retrieve: (value, key, findIndex)->
            if not key?
                key = 'id'

            matches = {}
            matches[key] = value

            if findIndex
                finder = _.findIndex
            else
                finder = _.find

            retVal = finder @original, matches

            if retVal? then retVal else null

        set: (resource)->
            if not resource.id?
                throw new Error 'Tried to set object which does not have id field.'

            retrieved = @retrieve resource.id

            if retrieved
                if retrieved isnt resource
                    _.assign retrieved, resource
                return false
            else
                @original.push resource
                return true

        remove: (resource)->
            oldLength = @original.length
            @original = _.remove @original, (_resource)->
                _resource isnt resource
            newLength = @original.length

            oldLength > newLength

        removeById: (id)->
            _resource = @retrieve id
            @remove _resource

        getMap: (key)->
            key = key or 'id'
            _.indexBy @original, key

        inverted: (flag)->
            if flag?
                @_inverted = !!flag
            @_inverted

        getFilter: ->
            @_filter

        setFilter: (filter)->
            if filter?
                @_filter = filter
            else
                @clearFilter()

        clearFilter: ->
            @_filter = null

        getSorter: ->
            @_sorter

        setSorter: (sorter)->
            if sorter?
                @_sorter = sorter
            else
                @clearSorter()

        clearSorter: ->
            @_sorter = defaultSorter

        setSorterOrInverse: (sorter)->
            if @_sorter is sorter
                @_inverted = not @_inverted
            else
                @setSorter sorter
                @_inverted = false

        transformed: ->
            transformed = @original
            if @_filter?.active()
                transformed = _.filter transformed, (resource)=>
                    @_filter.filter resource
            if @_sorter?
                transformed = @_sorter.sort transformed

            if @_inverted
                if transformed is @original
                    transformed = _.clone @original
                transformed.reverse()

            transformed

