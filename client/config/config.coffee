'use strict'

window.moduleConfig = 'hokuiConfig'

angular.module moduleConfig, [
    moduleCore
    'angular-google-analytics'
]

.config ($locationProvider)->
    $locationProvider
    .html5Mode true
    .hashPrefix '!'

.config ($urlRouterProvider)->
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

    $urlRouterProvider.otherwise ($injector)->
        $injector.get('$state').go '404', url: $injector.get('$location').absUrl()


.config (TokenProvider)->
    TokenProvider
    .setHeaderKey 'Access-Token'
    .setStorageKey 'token'
    .setTokenPrefix ''

.config (RestrictProvider)->
    RestrictProvider.setNext 'home'

.config (AuthProvider)->
    AuthProvider.setAutoCheck true

.run ($rootScope, Restrict, $state, Auth, Notify)->

    $rootScope.$on Auth.getAltStateChangeStart(), (ev, stateChangeStart, toState, toParams, fromState, fromParams)->
        result = Restrict toState
        first_visit = fromState.name is ''
        if not result.can
            Notify result.error, type: 'warn', delay: if first_visit then 500 else 0
            setTimeout ->
                $state.go result.next
            , 0
            stateChangeStart.preventDefault()

    $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error)->
        console.log 'error'

