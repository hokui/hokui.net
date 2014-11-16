'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'profile',
        url: '/profile'
        templateUrl: '/app/profile/profile.html'
        controller: 'ProfileCtrl'
        data:
            restrict:
                role: 'user'
                error: '/profile 以下へアクセスするにはログインしてください。'
                next: 'login'

.controller 'ProfileCtrl',
    ($scope) ->
