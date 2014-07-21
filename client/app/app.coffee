'use strict'

angular.module('hokuiApp', [
    'ngCookies'
    'ngResource'
    'ngSanitize'
    'ngAnimate'
    'ui.router'
    'ui.bootstrap'
]).config([
    '$stateProvider', '$urlRouterProvider', '$locationProvider',
    ($stateProvider, $urlRouterProvider, $locationProvider) ->
        $urlRouterProvider
        .otherwise('/')

        $locationProvider.html5Mode true

    ]
).config([
    '$httpProvider',
    ($httpProvider)->
        $httpProvider.defaults.headers.common = 'X-Requested-With': 'XMLHttpRequest'
])
