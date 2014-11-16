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
                $state.go 'home'
                Notify 'ログアウトしました。', type: 'ok'

        if Auth.active()
            $scope.message = "you are active as #{Auth.user().handle_name}."
        else
            $scope.message = "you are inactive."
