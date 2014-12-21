'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'home',
        url: '/'
        templateUrl: '/page/home/home.html'
        controller: 'HomeCtrl'

.controller 'HomeCtrl',
    ($scope, Token, Auth, $state, Notify, Env, $http) ->
        $scope.Auth = Auth
        $scope.Token = Token

        $scope.email = 'hokui.net@gmail.com'

        $scope.dev = Env.dev
