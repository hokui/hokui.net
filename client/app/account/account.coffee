'use strict'

angular.module('hokuiApp').config([
    '$stateProvider',
    ($stateProvider) ->
        $stateProvider.state(
            'login',
                url: '/login?next&message',
                templateUrl: 'app/account/login/login.html'
                controller: 'LoginCtrl'
        ).state(
            'logout',
                url: '/logout',
                templateUrl: 'app/account/logout/logout.html'
                controller: 'LogoutCtrl'
        )
])
