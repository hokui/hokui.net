'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'profile',
        url: '/profile'
        templateUrl: '/page/profile/profile.html'
        controller: 'ProfileCtrl'
        data:
            restrict:
                role: 'user'
                error: '/profile 以下へアクセスするにはログインしてください。'
                next: 'login'
            title: '北医ネット - プロフィール'

.controller 'ProfileCtrl',
    ($scope) ->
