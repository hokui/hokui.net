'use strict'

window.moduleConfig = 'hokuiConfig'

angular.module moduleConfig, [
    moduleCore
    modulePage
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
    TokenProvider.headerKey 'Access-Token'
    TokenProvider.storageKey 'token'
    TokenProvider.tokenPrefix ''

.config (RestrictProvider)->
    RestrictProvider.defaultMessage 'アクセスする権限がありません。'
    RestrictProvider.defaultNext 'home'

.config (AuthCheckerProvider)->
    AuthCheckerProvider.enabled true

.run ($rootScope, NotFound, Notify)->

    $rootScope.$on '$stateChangeError', (event, toState, toParams, fromState, fromParams, error)->
        Notify 'ページの表示に失敗しました。',
            period: -1
            type: 'danger'

.config (markedProvider)->
    markedProvider.setOptions
        gfm: true
