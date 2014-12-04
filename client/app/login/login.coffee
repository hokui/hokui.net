'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'login',
        url: '/login'
        templateUrl: '/app/login/login.html'
        controller: 'LoginCtrl'

.controller 'LoginCtrl',
    ($scope, $state, Auth, Notify) ->

        $scope.Auth = Auth
        $scope.credencials = {}

        $scope.performLogin = ()->
            Auth.login $scope.credencials
            .then ->
                $state.go 'home'
                Notify 'ログインしました。', type: 'ok'
            , ->
                $scope.message = 'invalid email or password'

        ###*
        FOR DEVEPOPMENT
        ###
        $scope.credencials.email ='admin@ec.hokudai.ac.jp'
        $scope.credencials.password = 'admin'
