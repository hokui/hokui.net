page = require 'page'
qs = require 'qs'

u = require './util'

currentContext = null

targetViews = {}
attachedVms = {}
currentRoute = null

redirectHistory = {}

__reload = false
__started = false

EventEmitter2 = require 'eventemitter2'
events = new EventEmitter2()


callHook = (vm, hook)->
    opt = vm.$options
    if typeof opt[hook] is 'function'
        opt[hook].call vm

emitEvent = (ev, context, next, past, status)->
    events.emit ev, context, next, past, status
    for name, vm of attachedVms
        vm.$emit ev, context, next, past, status

updatePage = (nextRoute, pastRoute, context)->
    status =
        next: null

    emitEvent '$pageUpdating', context, nextRoute, pastRoute, status
    if status.next
        if status.next is true
            return false
        if redirectHistory[context.path]
            throw new Error 'Your route setting contains redirect loop'
        redirectHistory[context.path] = true
        page.redirect status.next
        return false

    redirectHistory = {}
    pastContext = currentContext
    currentContext = context

    if pastContext?.path is currentContext.path and not __reload
        return true

    attachedViews = {}

    for route in nextRoute.familyLine
        for viewName, klass of route.views
            if attachedViews[viewName]
                console.warn "Attached vb twice to the view whose name is `#{viewName}`"

            if vm = attachedVms[viewName]
                if not __reload and vm instanceof klass
                    attachedViews[viewName] = true
                    vm._digest()
                    callHook vm, 'updated'
                    continue
                else
                    vm.$destroy true

            if targetView = targetViews[viewName]
                vm = targetView.vm.$addChild
                    replace: !klass.options.replace? or !!klass.options.replace
                , klass

                callHook vm, 'updated'

                vm.$mount().$appendTo targetView.el
                attachedVms[viewName] = vm
                attachedViews[viewName] = true
            else
                console.warn "The view named `#{viewName}` does not exist"

    for viewName, vm of attachedVms
        if not attachedViews[viewName]
            vm.$destroy true
            delete attachedVms[viewName]

    emitEvent '$pageUpdated', context, nextRoute, pastRoute
    __reload = false
    true

handlers = []

class Route
    routes = {}

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
                u.extend @parent.data, base, true
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

currentRoute = new Route


router = events

routerBase =
    go: (path, reload)->
        __reload = !!reload
        page path
    reload: ->
        @go currentContext.path, true
    start: (Vue)->
        if not __started
            if 'scrollRestoration' in history
                history.scrollRestoration = 'manual'
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
        if __started
            console.warn 'Do not register routes after started'
            return

        if Array.isArray params
            for p in params
                new Route p
        else
            new Route params

    views: attachedVms

u.extend router, routerBase

module.exports = (Vue, options)->
    options ?= {}

    Vue.directive 'view',
        isLiteral: true
        bind: ->
            name = @expression
            if targetViews[name]?
                throw new Error "The view whose name is `#{name}` is already binded to the document"
            targetViews[name] = this
        unbind: ->
            delete targetViews[@expression]

    Object.defineProperty Vue.prototype, '$context',
        get: ->
            currentContext

    Vue.prototype['$router'] = router
    Vue['router'] = router

    if options.autoStart
        Vue.nextTick ->
            router.start()
