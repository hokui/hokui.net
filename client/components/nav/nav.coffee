'use strict'

angular.module serviceName

.controller 'NavCtrl',
    ($scope, $state, Auth) ->
        $scope.Auth = Auth
        $scope.items = [
            title: 'Home'
            state: 'main'
        ,
            title: 'Help'
            state: 'help'
        ,
            title: 'Style'
            state: 'style'
        ,
            title: 'Admin'
            state: 'admin'
            visible: -> Auth.can 'admin'
        ]

        authItems =
            login:
                state: 'login'
                title: 'Login'
            logout:
                state: 'logout'
                title: 'Logout'

        $scope.signup =
            state: 'signup'
            title: 'Signup'
            visible: -> not Auth.active()

        $scope.toHref = (state)->
            $state.href(state)

        $scope.authItem = ->
            if Auth.active() then authItems.logout else authItems.login

        $scope.isVisible = (item)->
            if item.visible? then item.visible() else true

        $scope.navClass = (item)->
            active: $state.includes(item.state)
            disabled : if item.disable? then item.disable() else false

        $scope.isCollapsed = true



