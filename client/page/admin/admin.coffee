'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'admin',
        url: '/admin',
        views:
            '':
                templateUrl: '/page/admin/admin.html'
                controller: 'AdminCtrl'
            'main@admin':
                templateUrl: '/page/admin/main.html'
                controller: 'AdminMainCtrl'

        data:
            title: '北医ネット - 管理画面'
            restrict:
                role: 'admin'
                message: '/admin 以降へのアクセスは管理者権限が必要です。'
                next: 'home'


.controller 'AdminCtrl',
    ($scope, Auth, $state, Env) ->
        $scope.dev = Env.dev()

        $scope.isActive = (item)->
            state = item.state
            if state is 'admin'
                return $state.is state
            $state.includes state

        $scope.items = [
                title: 'TOP'
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
            ,
                title: 'お知らせ'
                state: 'admin.news'
        ]

        $scope.currentState = ->
            $state.current.name


.controller 'AdminMainCtrl',
    ($scope, Auth) ->

