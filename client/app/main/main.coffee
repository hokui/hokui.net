'use strict'

angular.module @appName
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

        if Auth.active()
            $scope.status = "you are active as #{Auth.user().handle_name}"
            $scope.message = "your info is below."
        else
            $scope.status = "you are inactive"
            $scope.message = "please login."
