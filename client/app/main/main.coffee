'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'main',
        url: '/'
        templateUrl: '/app/main/main.html'
        controller: 'MainCtrl'

.controller 'MainCtrl',
    ($scope, Token, Auth, $state, Notify) ->
        $scope.Auth = Auth
        $scope.Token = Token
