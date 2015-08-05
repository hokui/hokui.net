'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'reset_password',
        url: '/reset_password'
        templateUrl: '/page/reset_password/reset_password.html'
        controller: 'ResetPasswordCtrl'

        data:
            title: '北医ネット - パスワードのリセット'

.controller 'ResetPasswordCtrl',
    ($scope, $state, $http, Env, Notify)->
        $scope.email = ''

        $scope.performResetPassword = (valid)->
            if valid
                $http.post "#{Env.apiRoot()}/password_reset",
                    email: $scope.email
                .success ->
                    $state.go 'home'
                    Notify "#{$scope.email}宛にパスワードを送信しました。メールの案内に従ってログインしてください。", period: -1
                .error (err)->
                    Notify '登録されていないメールアドレスが入力されました。入力項目をご確認ください。',
                        period: -1
                        type: 'warn'
            else
                Notify '入力にエラーがあります。', type: 'warn'
