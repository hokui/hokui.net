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

.config ($urlRouterProvider, $urlMatcherFactoryProvider)->
    $urlRouterProvider.rule ($injector, $location)->
        path = $location.url()
        replaced = false

        if path isnt '/'
            if path.indexOf('/?') > 0
                replaced = true
                path = path.replace '/?', '?'

            if path[path.length - 1] is '/'
                replaced = true
                path = path.replace /\/$/, ''

        if replaced
            return path
        else
            return false

    $urlRouterProvider.otherwise ($injector)->
        $injector.get('NotFound')()


.config (TokenProvider)->
    TokenProvider
    .setHeaderKey 'Access-Token'
    .setStorageKey 'token'
    .setTokenPrefix ''

.config (RestrictProvider)->
    RestrictProvider.setNext 'home'

.config (AuthCheckerProvider)->
    AuthCheckerProvider.enabled true

.config (TitleProvider)->
    TitleProvider.setDefault '北医ネット'

.run ($rootScope, Restrict, $state, AuthChecker, Notify)->

    $rootScope.$on AuthChecker.altStateChangeStart(), (ev, toState, toParams, fromState, fromParams)->
        result = Restrict toState
        first_visit = fromState.name is ''
        if not result.can
            setTimeout ->
                $state.go result.next
                Notify result.error, type: 'warn', delay: if first_visit then 500 else 0
            , 0
            ev.preventDefault()

    $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error)->
        Notify 'ページの表示に失敗しました。',
            period: -1
            type: 'danger'


