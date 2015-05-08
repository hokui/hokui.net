'use strict'

angular.module moduleCore

.factory 'ResourceFilter', ->
    class
        constructor: (params)->
            @_parent = null
            @_active = true
            @_children = []

            default_params =
                label: ''
                alternative: false
                slug: null
                value: null
                parent: null
                filter: @_defaultFilterFunc

            p = if _.isObject params then _.assign default_params, params else default_params

            @label = p.label
            @slug = p.slug
            @value = p.value
            @alternative = !!p.alternative
            @_parent = p.parent
            @_filterFunc = p.filter

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
                    for child in @_children
                        child._active = false
                    if flag
                        @_children[0]._active = true

                if @_parent?.alternative
                    for child in @_parent._children
                        if child isnt this
                            child._active = false

                    @_parent._active = flag

            return @_active

        _defaultFilterFunc: (resource)->
            for child in @_children
                if child._active
                    if not child.getFilterFunc().call child, resource
                        return false
            return true

        getFilterFunc: ->
            @_filterFunc


.factory 'ResourceSorter', ->
    class
        constructor: (sortFunc)->
            if _.isFunction sortFunc
                @_sortFunc = sortFunc
            else
                @_sortFunc = (a, b)->
                    a.id > b.id

        getSortFunc: ->
            @_sortFunc

.factory 'ResourceFieldSorter', (ResourceSorter)->
    class extends ResourceSorter
        constructor: (keys)->
            super (a, b)->
                for key in keys
                    diff = 0
                    if _.isString key
                        reversed =  key[0] is '-'
                        if reversed
                            key = key.slice 1
                        A = a[key]
                        B = b[key]
                        if A is B
                            continue
                        if _.isString(A) and _.isString(B)
                            diff = A.localeCompare B
                        else
                            diff = A - B

                        if reversed
                            diff = - diff

                    else if _.isFunction key
                        diff = key a, b

                    if diff isnt 0
                        return diff

            0

.factory 'ResourceStore', ->
    class
        constructor: (original)->
            if _.isArray original
                @original = original
            else
                throw new Error 'resources must be Array'

            @_inverted = false

        count: ->
            @original.length

        retrieve: (value, key)->
            if not key?
                key = 'id'

            matches = {}
            matches[key] = value

            retVal = _.find @original, matches

            if retVal? then retVal else null

        set: (resource)->
            if not resource.id?
                throw new Error 'Tried to set object which does not have id field.'

            retrieved = @retrieve resource.id

            if retrieved?
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
            map = _.indexBy @original, key
            if @original.length isnt _.size map
                return null
            map

        inverted: (flag)->
            if flag?
                @_inverted = !!flag
            @_inverted

        getFilter: ->
            @_filter

        setFilter: (filter)->
            @_filter = filter

        clearFilter: ->
            @_filter = null

        getSorter: ->
            @_sorter

        setSorter: (sorter)->
            if sorter isnt @_sorter
                @_sorter = sorter
                @_inverted = false

        clearSorter: ->
            @_sorter = null
            @_inverted = false

        setSorterOrInverse: (sorter)->
            if @_sorter is sorter
                @_inverted = not @_inverted
            else
                @_sorter = sorter
                @_inverted = false

        transformed: ->
            if @_filter?.active()
                transformed = _.filter @original, @_filter.getFilterFunc(), @_filter
            else
                transformed = _.clone @original

            if @_sorter?
                transformed.sort @_sorter.getSortFunc()

            if @_inverted
                transformed.reverse()

            transformed
