
angular.module('hokuiApp').controller('LoginCtrl', [
    '$scope', '$log', '$state', '$stateParams', 'Token', 'Auth',
    ($scope, $log, $state, $stateParams, Token, Auth) ->
        $scope.Token = Token
        $scope.current = Auth.current

        params = $stateParams
        if params.message?
            $scope.message = params.message

        if Auth.current.active
            $scope.title = "you are active as #{Auth.current.user.handle_name}."
        else
            $scope.title = "you are inactive."

        $scope.performLogin = ()->
            Auth.login(
                email: $scope.email
                password: $scope.password
            )

        $scope.$on 'authenticate', (event, data)->
            if params.next?
                next = params.next
            else
                next = 'main'
            $state.go next

])
