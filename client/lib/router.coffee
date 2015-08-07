page = require 'page'
qs = require 'qs'

targetViews = {}
attachedModels = {}
currentContext = null
redirectHistory = {}
__reload = false
__started = false

EventEmitter2 = (require 'eventemitter2')
events = new EventEmitter2()

extend = (a, b, copy)->
    target = if copy then (extend {}, a, false) else a
    for k, v of b
        target[k] = v
    target


emitEvent = (ev, context, next, past, status)->
    events.emit ev, context, next, past, status
    for name, model of attachedModels
        model.$emit ev, context, next, past, status


updatePage = (nextRoute, pastRoute, context)->
    status =
        next: null

    emitEvent '$pageUpdating', context, nextRoute, pastRoute, status
    if status.next
        if redirectHistory[context.path]
            throw new Error "Your route setting contains redirect loop"
        redirectHistory[context.path] = true
        page.redirect status.next
        return false

    redirectHistory = {}
    currentContext = context

    if pastRoute is nextRoute and not __reload
        return true

    attachedViews = {}

    for route in nextRoute.familyLine
        for viewName, modelClass of route.views
            if attachedViews[viewName]
                console.warn "Attached vb twice to the view whose name is `#{viewName}`"

            if model = attachedModels[viewName]
                if not __reload and model.__proto__.constructor is modelClass
                    attachedViews[viewName] = true
                    continue
                else
                    model.$destroy true

            if targetView = targetViews[viewName]
                model = new modelClass
                    replace: !modelClass.options.replace? or !!modelClass.options.replace

                model.$mount().$appendTo targetView.el
                attachedModels[viewName] = model
                attachedViews[viewName] = true
            else
                console.warn "The view named `#{viewName}` does not exist"

    for viewName, model of attachedModels
        if not attachedViews[viewName]
            model.$destroy true
            delete attachedModels[viewName]

    emitEvent '$pageUpdated', context, nextRoute, pastRoute
    __reload = false

    true

handlers = []

class Route
    routes = {}
    currentRoute = new Route
    @registerRoutes = ->
        for url, route of routes
            route.register()

    constructor: (params)->
        params ?= {}

        @parent = params.parent or null
        @views = params.views or {}
        @data = do =>
            base = params.data or {}
            if @parent
                extend @parent.data, base, true
            else
                base


        @abstract = !params.url or !!params.abstract
        @url = do =>
            if params.url
                if @parent and @parent isnt this
                    return @parent.url + params.url
                else
                    return params.url
            else
                return ''

        @familyLine = if @parent? then @parent.familyLine.concat [this] else [this]

        if Array.isArray params.subs
            for sub in params.subs
                sub.parent = this
                new Route sub
                if sub.url is '/'
                    @abstract = true

        if not @abstract
            if routes[@url]?
                throw new Error "Tried to define dupricated routes `#{@url}`"
            routes[@url] = this

    route: (params)->
        new Route params

    register: ->
        page @url, (context, next)=>
            success = updatePage this, currentRoute, context
            if success
                currentRoute = this


router = events

routerBase =
    go: (path, reload)->
        __reload = !!reload
        page path
    start: (Vue)->
        if not __started
            page '*', (context, next)->
                context.query = qs.parse context.querystring
                next()
            Route.registerRoutes()
            page()
        else
            console.warn 'Tried to start routing twice'
        __started = true

    trimQuery: ->
        page.redirect currentContext.pathname

    route: (params)->
        if Array.isArray params
            for p in params
                new Route p
        else
            new Route params

    views: attachedModels

extend router, routerBase

module.exports = (Vue, options)->
    options ?= {}
    viewName = ((typeof options.viewName is 'string') and options.viewName) or 'view'
    routerName = ((typeof options.routerName is 'string') and options.routerName) or 'router'

    Vue.directive viewName,
        isLiteral: true
        bind: ->
            name = @expression
            if targetViews[name]?
                throw new Error "The view whose name is `#{name}` is already binded to the document"
            targetViews[name] = this
        unbind: ->
            delete targetViews[@expression]

    Vue.prototype.$context = -> currentContext
    Vue.prototype['$'+routerName] = router
    Vue[routerName] = router

    if options.autoStart
        Vue.nextTick =>
            router.start()
