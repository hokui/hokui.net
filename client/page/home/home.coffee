'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'home',
        url: '/'
        templateUrl: '/page/home/home.html'
        controller: 'HomeCtrl'
        resolve:
            newss: (News, ResourceStore, Auth)->
                if Auth.active()
                    News.query(count: 3).$promise.then (data)->
                        new ResourceStore data
                else
                    []


.controller 'HomeCtrl',
    ($scope, $state, Auth, Notify, Env, newss, News) ->
        $scope.email = 'hokui.net@gmail.com'

        $scope.Auth = Auth
        $scope.credencials = {}
        $scope.keepLogin = false
        $scope.error = false

        $scope.performLogin = (valid)->
            if valid
                Auth.login $scope.credencials, $scope.keepLogin
                .then ->
                    News.query(count: 3).then (data)->
                        $scope.newss = data
                    $state.go 'home'
                    Notify 'ログインしました。', type: 'ok'
                , (error)->
                    $scope.error = true
                    Notify 'ログインに失敗しました。入力項目をご確認ください。', type: 'warn'
            else

        seed = Env.seed 'login'
        if seed?
            angular.extend $scope.credencials, seed.credencials
            $scope.keepLogin = seed.keepLogin


        if Auth.active()
            $scope.newss = newss
