'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'activate',
        url: '/activate?activation_token'
        templateUrl: '/page/activate/activate.html'
        controller: 'ActivateCtrl'

.controller 'ActivateCtrl',
    ($scope, User, $stateParams, $timeout, $http, $state, Env) ->
        token = $stateParams.activation_token
        if not token?
            $state.go 'main'

        $scope.status = '処理中..'

        admin = 'hokui.net@gmail.com'

        $http.post "#{Env.apiRoot()}/users/activate",
            activation_token: token
        .success (data)->
            sec = 5
            left = false
            unregister = $scope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
                left = true
                unregister()
            countDown = ->
                $scope.status = "正常に受理されました。管理者の承認をお待ちください。#{sec}秒後にトップに戻ります"
                sec = sec - 1
                if sec < 0
                    if not left
                        $state.go 'home'
                else
                    $timeout countDown, 1000
            countDown()

        .error (err)->
            $scope.status = "すでに登録の受付が行われているか、無効なURLです。ご不明な点がありましたら、#{admin}までお問い合わせください。"
