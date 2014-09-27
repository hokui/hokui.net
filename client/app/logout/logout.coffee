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

        if Auth.active()
            $scope.message = "you are active as #{Auth.user().handle_name}."
        else
            $scope.message = "you are inactive."
