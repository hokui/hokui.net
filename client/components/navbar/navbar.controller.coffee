'use strict'

angular.module('hokuiApp').controller 'NavbarCtrl', [
    '$scope', '$state', 'Auth',
    ($scope, $state, Auth) ->
        $scope.items = [
            title: 'Home'
            link: 'main'
        ,
            title: 'Admin'
            link: 'admin'
        ]
        $scope.auth =
            link : if Auth.current.active then 'logout' else 'login'
            title : if Auth.current.active then 'Logout' else 'Login'

        $scope.isCollapsed = true


]
