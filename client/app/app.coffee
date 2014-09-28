'use strict'

@appName = 'hokuiApp'

angular.module @appName, [
    'ngCookies'
    'ngResource'
    'ngSanitize'
    'ngAnimate'
    'ui.router'
    'ui.bootstrap'
    @serviceName
]

.config ($urlRouterProvider, $locationProvider) ->
    $urlRouterProvider.otherwise '/'
    $locationProvider.html5Mode true
    $locationProvider.hashPrefix '!'

    $urlRouterProvider.rule ($injector, $location)->
        path = $location.url()
        replaced = false

        if path.indexOf('/?') > 0
            replaced = true
            path = path.replace('/?', '?')

        if path is not '/' or '/' is path[path.length - 1]
            replaced = true
            path = path.replace /\/$/, ''

        if replaced
            return path
        else
            return false


.config (TokenProvider)->
    TokenProvider.tokenKey 'Access-Token'
    TokenProvider.storageKey 'token'
    TokenProvider.tokenPrefix ''


.run ($rootScope, PageRestriction, $state, Auth)->

    hooking_first_change = true
    unregister = $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
        go = ->
            hooking_first_change = false
            $state.transitionTo toState, toParams

        Auth.check().then go, go
        ev.preventDefault()
        unregister()


    $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
        if hooking_first_change
            return
        can = PageRestriction(toState, fromState)
        if not can
            ev.preventDefault()


