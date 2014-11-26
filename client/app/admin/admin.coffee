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

        data:
            restrict:
                role: 'admin'
                error: '/admin 以降へのアクセスは管理者権限が必要です。'


.controller 'AdminCtrl',
    ($scope, Auth, $state) ->
        $scope.isActive = (item)->
            state = item.state
            if state is 'admin'
                return $state.is state
            $state.includes state

        $scope.items = [
                title: '管理TOP'
                state: 'admin'
            ,
                title: 'ユーザー'
                state: 'admin.user'
            ,
                title: '学年'
                state: 'admin.year'
            ,
                title: '教科'
                state: 'admin.subject'
            ,
                title: '学期'
                state: 'admin.semester'
        ]


.controller 'AdminMainCtrl',
    ($scope, Auth) ->


.controller 'AdminSubjectCtrl',
    ($scope) ->


