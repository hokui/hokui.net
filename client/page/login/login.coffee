'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'login',
        url: '/login'
        templateUrl: '/page/login/login.html'
        controller: 'LoginCtrl'

.controller 'LoginCtrl',
    ($scope, $state, Auth, Notify, Env) ->
        $scope.Auth = Auth
        $scope.credencials = {}
        $scope.keepLogin = false

        $scope.performLogin = ()->
            Auth.login $scope.credencials, $scope.keepLogin
            .then ->
                $state.go 'home'
                Notify 'ログインしました。', type: 'ok'
            , ->
                $scope.message = 'invalid email or password'

        seed = Env.seed 'login'
        if seed?
            angular.extend $scope.credencials, seed.credencials
            $scope.keepLogin = seed.keepLogin
