u = require './util'

class Collection
    constructor: (list)->
        @$ = list
        @_reversed = false

        @options =
            sorter: null
            filters: {}

        @transform()

    $set: (list)->
        @$ = list
        @transoformOption = {}
        @transform()

    getSorter: (name)->
        name and this["sort_by_#{name}"]

    getFilter: (name)->
         name and this["filter_by_#{name}"]


    sort: (name)->
        if not @getSorter name
            console.warn "No registered sorter name `#{name}`"
            return
        if @options.sorter is name
            @_reversed = true
        else
            @_reversed = false
        @options.sorter = name
        @transform()

    sorted: (name)->
        @options.sorter is name

    filter: (name, value)->
        filter = @getFilter name
        if not filter
            console.warn "No registered filter name `#{name}`"
            return
        @options.filters[name] = value

        @transform()

    filtered: (name, value)->
        @options.filters[name] is value

    reversed: ->
        @_reversed

    transform: ->
        @$$ = u.copy @$
        for name, value of @options.filters
            console.log name
            @$$ = @$$.filter @getFilter(name)(value)

        if sorter = @getSorter @options.sorter
            @$$.sort sorter

        if @_reversed
            @$$.reverse()
        console.log @$$
        @$$

    transformed: ->
        @$$

module.exports = Collection
