'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'admin',
        url: '/admin',
        views:
            '':
                templateUrl: '/app/admin/admin.html'
                controller: 'AdminCtrl'
            'main@admin':
                templateUrl: '/app/admin/main.html'
                controller: 'AdminMainCtrl'

    .state 'admin.subject',
        url: '/subject',
        views:
            'main@admin':
                templateUrl: '/app/admin/subject.html'
                controller: 'AdminSubjectCtrl'

.controller 'AdminCtrl',
    ($scope, Auth, $state) ->
        if not Auth.current.user?.admin
            $state.go 'main'

        $scope.isActive = (state)->
            if state is 'admin'
                return $state.is(state)
            $state.includes(state)

        $scope.items = [
                title: '管理TOP'
                state: 'admin'
            ,
                title: 'ユーザー'
                state: 'admin.user'
            ,
                title: '期/学期'
                state: 'admin.year'
            ,
                title: '教科'
                state: 'admin.subject'
        ]


.controller 'AdminMainCtrl',
    ($scope, Auth) ->


.controller 'AdminSubjectCtrl',
    ($scope) ->


