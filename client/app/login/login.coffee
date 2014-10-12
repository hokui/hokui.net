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

        $scope.credencials = {}

        if Auth.active()
            $scope.message = "You are active as #{Auth.user().handle_name}."
        else
            $scope.message = "You are inactive. Why not login?"

        $scope.performLogin = ()->
            Auth.login $scope.credencials
            .then ->
                $state.go 'main'
                Notify 'ログインしました。', type: 'success'
            , ->
                $scope.message = 'invalid email or password'

        ###*
        FOR DEVEPOPMENT
        ###
        $scope.credencials.email ='admin@ec.hokudai.ac.jp'
        $scope.credencials.password = 'admin'
