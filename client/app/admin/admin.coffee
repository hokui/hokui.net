'use strict'

angular.module('hokuiApp').config([
    '$stateProvider',
    ($stateProvider) ->
        $stateProvider.state(
            'admin',
                url: '/admin',
                templateUrl: 'app/admin/admin.html'
                controller: 'AdminCtrl'
        ).state(
            'admin.user',
                url: '/user',
                views:
                    'user@admin':
                        templateUrl: 'app/admin/user.html'
                        controller: 'AdminUserCtrl'
        )
])
