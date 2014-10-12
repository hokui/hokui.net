'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'logout',
        url: '/logout'
        templateUrl: '/app/logout/logout.html'
        controller: 'LogoutCtrl'

.controller 'LogoutCtrl',
    ($scope, $state, Auth, Notify) ->
        $scope.Auth = Auth

        $scope.performLogout = ()->
            Auth.logout()
            .then ->
                console.log 'logout'
                $state.go 'main'
                Notify 'ログアウトしました。', type: 'info'

        if Auth.active()
            $scope.message = "you are active as #{Auth.user().handle_name}."
        else
            $scope.message = "you are inactive."
