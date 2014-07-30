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

        # memo:
        # Tokenがない状態で認証が必要なAPIを叩かれた場合、リクエスト前にチェックしたい感もあるが
        # Tokenを必要としないAPIもあり、飛ばす前はTokenの有効性は常に不明。
        # とりあえずリクエスト飛ばしてみて、それでダメだったらログイン画面に飛ばす。
        # これで動的に認証が必要なページだけloginに飛ばせる。
        $httpProvider.interceptors.push [
            '$q', '$injector', '$rootScope' ,'$location', '$log',
            ($q, $injector, $rootScope, $location, $log)->
                responseError: (rejection)->
                    # 循環参照回避
                    $q.reject(rejection)

                    Auth = $injector.get('Auth')
                    if rejection.status is 401
                        Auth.silentLogout()
                        $log.log(rejection)
                        $log.log('with request failed, automatically logout and jump to login page')
                        # 401だけじゃなくてadminが必要かどうかも返して欲しい
                        $rootScope.$broadcast 'unauthorized', message: 'You need to log in.'
                        # cur = $location.path()
                        # $location.path('/login').search('next': cur)
        ]
]).run([
    '$rootScope', '$state', '$stateParams'
    ($rootScope, $state, $stateParams)->
        $rootScope.$on 'unauthorized', (event, data)->
            if data.next?
                next = data.next
            else
                next = $state.current.name
            $state.go 'login',
                message: data.message
                next: next

        $rootScope.$on 'adminonly', (event, data)->
            if data.next?
                next = data.next
            else
                next = $state.current.name
            $state.go next,
                message: data.message

        $rootScope.$on 'deauthorized', (event, data)->
            $state.go 'main'

        $rootScope.$on 'authorized', (event, data)->
            params = $stateParams
            console.log params
            if params.next?
                next = params.next
            else
                next = 'main'
            $state.go next


        $rootScope.isActive = (state)->
            $state.includes(state)

])



