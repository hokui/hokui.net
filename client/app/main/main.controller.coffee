angular.module('hokuiApp').controller('MainCtrl', [
    '$scope', 'Token', 'Auth'
    ($scope, Token, Auth) ->
        $scope.message = 'This is new hokui.net powered by Rails and Angular.js!!'
        $scope.current = Auth.current
        $scope.Token = Token


])
