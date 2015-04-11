'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'profile.password',
        url: '/password'
        views:
            'main@profile':
                templateUrl: '/page/profile/password/password.html'
                controller: 'ProfilePasswordCtrl'
        data:
            title: '北医ネット - パスワードの再設定'

.controller 'ProfilePasswordCtrl',
    ($scope, $http, Env, $state, Notify)->
        $scope.currentPassword = ''
        $scope.password = ''

        $scope.performChangePassword = (valid)->
            if valid
                $http.patch "#{Env.apiRoot()}/profile/password",
                    current_password: $scope.currentPassword
                    password: $scope.password
                .success (data)->
                    $state.go 'profile'
                    Notify 'パスワードを変更しました。'
                .error (err)->
                    Notify 'パスワードが間違っています。', type: 'warn'
                    $scope.errors = err.errors
            else
                Notify '入力にエラーがあります。', type: 'warn'

