'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'main',
        url: '/'
        templateUrl: '/app/main/main.html'
        controller: 'MainCtrl'

.controller 'MainCtrl',
    ($scope, Token, Auth) ->
        $scope.current = Auth.current
        $scope.Token = Token

        if Auth.current.active
            $scope.status = "you are active as #{Auth.current.user.handle_name}"
            $scope.message = "your info is below."
        else
            $scope.status = "you are inactive"
            $scope.message = "please login."
