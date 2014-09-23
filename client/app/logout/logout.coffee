'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'logout',
        url: '/logout'
        templateUrl: '/app/logout/logout.html'
        controller: 'LogoutCtrl'

.controller 'LogoutCtrl',
    ($scope, $state, Auth) ->
        $scope.Auth = Auth

        $scope.performLogout = ()->
            Auth.logout()
            .then ->
                $state.go 'main'

        $scope.$on 'event:logout', (event, data)->
            $state.go 'main'

        if Auth.current.active
            $scope.message = "you are active as #{Auth.current.user.handle_name}."
        else
            $scope.message = "you are inactive."
