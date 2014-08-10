'use strict'

angular.module('hokuiApp', [
    'ngCookies',
    'ngResource',
    'ngSanitize',
    'ngAnimate',
    'ui.router',
    'ui.bootstrap',
    'angularLocalStorage',
]).config([
    '$stateProvider', '$urlRouterProvider', '$locationProvider',
    ($stateProvider, $urlRouterProvider, $locationProvider) ->
        $urlRouterProvider.otherwise('/')
        $locationProvider.html5Mode true
    ]
).config([
    '$httpProvider',
    ($httpProvider)->
        $httpProvider.defaults.headers.common = 'X-Requested-With': 'XMLHttpRequest'

        $httpProvider.interceptors.push [
            '$q', '$injector', '$rootScope', '$log',
            ($q, $injector, $rootScope, $log)->
                responseError: (rejection)->
                    $q.reject(rejection)

                    Auth = $injector.get('Auth')
                    if rejection.status is 401
                        Auth.silentLogout()
                        $rootScope.$broadcast 'unauthorize', message: 'You need to log in.'

                    if rejection.status is 403
                        $rootScope.$broadcast 'adminonly', message: 'Invalid permission'
        ]
]).run([
    '$rootScope', '$state', '$log'
    ($rootScope, $state, $log)->
        $rootScope.$on 'unauthorize', (event, data)->
            if data.next?
                next = data.next
            else
                next = $state.current.name
            $state.go 'login',
                message: data.message
                next: next

        $rootScope.$on 'adminonly', (event, data)->
            if data.message?
                # memo: wanna replace $log by bootstrap alert
                $log.log data.message
            $state.go $state.current


        $rootScope.isActive = (state)->
            $state.includes(state)

])



