'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.user',
        url: '/user',
        views:
            'main@admin':
                templateUrl: '/page/admin/user/user.html'
                controller: 'AdminUserCtrl'
                resolve:
                    users: (User)->
                        User.query().$promise
                    years: (ClassYear)->
                        ClassYear.query().$promise

            'main@admin.user':
                templateUrl: '/page/admin/user/list.html'
                controller: 'AdminUserListCtrl'

    .state 'admin.user.detail',
        url: '/:id',
        views:
            'main@admin.user':
                templateUrl: '/page/admin/user/detail.html'
                controller: 'AdminUserDetailCtrl'


.controller 'AdminUserCtrl',
    ($scope, $http, $state, Notify, ResourceStore, Env, users, years) ->
        $scope.users = ResourceStore users
        $scope.years = ResourceStore years

        $scope.approvable = (user)->
            user.activation_state is 'active' and user.approval_state is 'waiting'

        $scope.getYear = (user)->
            $scope.years.retrieve(user.class_year_id).year

        $scope.doApproveUser = (user)->
            if not $scope.approvable(user)
                console.log 'cant approve'

            $http.post "#{api.apiRoot()}/users/#{user.id}/approve",
                {}
            .success (data)->
                user.approval_state = 'approved'
                Notify "「#{user.handle_name}」さんを認証しました。"


        $scope.doDeleteUser = (user)->
            user_name = user.handle_name
            user.$remove (data)->
                $scope.users.del user
                $state.go 'admin.user'
                Notify "「#{user_name}」さんを削除しました。", type: 'danger'
            , (err)->
                console.log err
                console.log 'cant delete user'

.controller 'AdminUserListCtrl',
    ($scope, $templateCache, Notify) ->
        # activation_state
        #   pending : メール認証待ち
        #   active  : メール認証済
        # approval_state
        #   waiting : 管理人承認待ち
        #   approved: active!

        approvingUsers = {}


        $scope.approveUser = (user)->
            if approvingUsers[user.id]?
                $scope.doApproveUser user
            else
                approvingUsers[user.id] = true
                Notify 'もう一度クリックすると認証します。'


        $scope.status = (user)->
            t = ''
            switch user.activation_state
                when 'pending'
                    t = 'pending'
                when 'active'
                    switch user.approval_state
                        when 'waiting'
                            if approvingUsers[user.id]?
                                t = 'approve_processing'
                            else
                                t = 'waiting'
                        when 'approved'
                            t = 'active'
                        else
                            t = 'annon'
                else
                    t = 'annon'

            template = "admin.user.list.status.#{t}.html"


.controller 'AdminUserDetailCtrl',
    ($scope, $stateParams, Notify) ->
        user_id = $stateParams.id

        $scope.deleting = false
        $scope.user = $scope.users.retrieve user_id

        $scope.deleteBtnLabel = ()->
            if $scope.deleting
                return "マジで削除する"
            else
                return '削除する'

        $scope.stopDeleting = ->
            $scope.deleting = false
            Notify '削除を中断しました。', type: 'warning'

        $scope.deleteUser = (user)->
            if $scope.deleting
                $scope.doDeleteUser user
            else
                $scope.deleting = true
                Notify 'もう一度クリックすると削除します。', type: 'danger'



