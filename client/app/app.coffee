'use strict'

appName = 'hokuiApp'

angular.module appName, [
    'ngCookies'
    'ngResource'
    'ngSanitize'
    'ngAnimate'
    'ui.router'
    'ui.bootstrap'
    'angularLocalStorage'
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
