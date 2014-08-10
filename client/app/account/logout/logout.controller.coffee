
angular.module('hokuiApp').controller('LogoutCtrl', [
    '$scope', '$log', '$state', 'Auth',
    ($scope, $log, $state, Auth) ->
        $scope.performLogout = ()->
            Auth.logout()

        $scope.$on 'deauthenticate', (event, data)->
            $state.go 'main'

        if Auth.current.active
            $scope.title = "you are active as #{Auth.current.user.handle_name}."
        else
            $scope.title = "you are inactive."
])
