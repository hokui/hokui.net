'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'activate',
        url: '/activate?activation_token?fake'
        templateUrl: '/page/activate/activate.html'
        controller: 'ActivateCtrl'
        data:
            title: '北医ネット - ユーザー認証'

.controller 'ActivateCtrl',
    ($scope, $stateParams, $timeout, $http, $state, Env, Notify, NotFound) ->
        token = $stateParams.activation_token
        fake = $stateParams.fake
        if token? or (fake? and Env.dev)
        else
            NotFound()
            return

        $scope.completed = false
        $scope.template = 'activate.processing.html'

        onSuccess = (data)->
            $scope.completed = true
            $scope.template = 'activate.success.html'
            Notify 'ユーザー認証に成功しました。管理者の承認をお待ちください。',
                period: -1
                autoHide: false

        onError = (err)->
            $scope.completed = true
            $scope.template = 'activate.error.html'
            Notify 'すでに認証が行われているか、無効なURLです。',
                period: -1
                autoHide: false
                type: 'danger'

        if fake?
            if fake is 'fail'
                $timeout onError, 2000
            else
                $timeout onSuccess, 2000
        else
            $http.post "#{Env.apiRoot()}/users/activate",
                activation_token: token
            .success onSuccess
            .error onError
