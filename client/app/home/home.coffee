'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'home',
        url: '/'
        templateUrl: '/app/home/home.html'
        controller: 'HomeCtrl'

.controller 'HomeCtrl',
    ($scope, Token, Auth, $state, Notify) ->
        $scope.Auth = Auth
        $scope.Token = Token

        $scope.email = 'hokui.net@gmail.com'

        $scope.click = ->
            console.log('hey')
