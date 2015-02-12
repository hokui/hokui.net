'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'home',
        url: '/'
        templateUrl: '/page/home/home.html'
        controller: 'HomeCtrl'

.controller 'HomeCtrl',
    ($scope, Env) ->
        $scope.email = 'hokui.net@gmail.com'

        $scope.dev = Env.dev()
