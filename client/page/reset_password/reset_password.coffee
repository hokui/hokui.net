'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'reset_password',
        url: '/reset_password'
        templateUrl: '/page/reset_password/reset_password.html'
        controller: 'ResetPasswordCtrl'
        data:
            title: '北医ネット - パスワードの再設定'

.controller 'ResetPasswordCtrl',
    ($scope) ->


