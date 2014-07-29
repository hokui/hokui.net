
angular.module('hokuiApp').controller('LogoutCtrl', [
    '$scope', '$log', '$location', 'Auth',
    ($scope, $log, $location, Auth) ->
        $scope.current = Auth.current
        $scope.performLogout = ()->
            Auth.logout()


])
