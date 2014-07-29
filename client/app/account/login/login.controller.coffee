
angular.module('hokuiApp').controller('LoginCtrl', [
    '$scope', '$log', '$state', '$stateParams', 'Token', 'Auth',
    ($scope, $log, $state, $stateParams, Token, Auth) ->
        $scope.Token = Token
        $scope.current = Auth.current

        $scope.params = $stateParams

        $scope.performLogin = ()->
            Auth.login(
                email: $scope.email
                password: $scope.password
            )
])
