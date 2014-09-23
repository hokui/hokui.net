'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'activate',
        url: '/activate?email_local&activation_token'
        templateUrl: '/app/activate/activate.html'
        controller: 'ActivateCtrl'

.controller 'ActivateCtrl',
    ($scope, User, $stateParams, $timeout, $http, $state) ->
        email = $stateParams.email_local
        token = $stateParams.activation_token
        if (not email?) or (not token?)
            $state.go 'main'

        $scope.status = '処理中..'

        admin = 'hokui.net@gmail.com'

        $http.post '/api/users/activate',
            email_local: email
            activation_token: token
        .success (data) =>
            period = 5
            sec = period
            countDown = ->
                $scope.status = "正常に受理されました。管理者の承認をお待ちください。#{sec}秒後にトップに戻ります"
                sec = sec - 1
                if sec < 0
                    $state.go 'main'
                else
                    $timeout countDown, 1000
            countDown()
        .error (err) ->
            $scope.status = "すでに登録の受付が行われているか、無効なURLです。ご不明な点がありましたら、#{admin}までお問い合わせください。"
