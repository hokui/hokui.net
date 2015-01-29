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
                    classYears: (ClassYear)->
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
    ($scope, $http, $state, Notify, ResourceStore, Env, users, classYears) ->
        $scope.users = ResourceStore users
        $scope.classYears = ResourceStore classYears

        $scope.approvable = (user)->
            user.activation_state is 'active' and user.approval_state is 'waiting'

        $scope.getClassYearLabel = (user)->
            $scope.classYears.retrieve(user.class_year_id).year

        $scope.doApproveUser = (user)->
            if not $scope.approvable(user)
                Notify 'すでに認証済みのユーザーです。', type: 'warn'

            $http.post "#{api.apiRoot()}/users/#{user.id}/approve",
                {}
            .success (data)->
                user.approval_state = 'approved'
                Notify "「#{user.handle_name}」さんを認証しました。"
            .error (res)->
                Notify 'ユーザーの認証に失敗しました。', type: 'danger'

.controller 'AdminUserListCtrl',
    ($scope, $templateCache, Notify, ResourceFilterItem, ResourceFilterItems, ResourceFilterGroup) ->
        # order
        $scope.predicate = 'id'
        $scope.reversed = false
        $scope.predicateStatus = ['activation_state', 'approval_state']

        $scope.orderBy = (field)->
            if $scope.predicate is field
                $scope.reversed = not $scope.reversed
            else
                $scope.predicate = field
                $scope.reversed = false


        $scope.stateFilter = new ResourceFilterItems()
        .addItem
            label: 'メール認証待ち'
            search: (user)->
                user.activation_state is 'pending'
        .addItem
            label: '管理人承認待ち'
            search: (user)->
                user.activation_state is 'active' and user.approval_state is 'waiting'
        .addItem
            label: '管理者'
            search: (user)->
                user.admin

        $scope.classYearFilter = new ResourceFilterItems()
        angular.forEach $scope.classYears, (cy)->
            $scope.classYearFilter.addItem
                label: "#{cy.year}期",
                search: (model)->
                    model.class_year_id is cy.id

        $scope.nameFilter = new ResourceFilterItem
            search: (model)->
                exp = new RegExp @value
                hname = model.handle_name.match exp
                fname = model.full_name.match exp
                hname or fname


        $scope.userFilter = new ResourceFilterGroup()
        .add $scope.stateFilter
        .add $scope.classYearFilter
        .add $scope.nameFilter

        approvingUsers = {}

        $scope.approveUser = (user)->
            if approvingUsers[user.id]
                $scope.doApproveUser user
            else
                approvingUsers[user.id] = true
                Notify 'もう一度クリックすると認証します。'

        $scope.cancelApproveUser = (user)->
            console.log user

        # activation_state
        #   pending : メール認証待ち
        #   active  : メール認証済
        # approval_state
        #   waiting : 管理人承認待ち
        #   approved: active!

        $scope.status = (user)->
            t = ''
            switch user.activation_state
                when 'pending'
                    t = 'pending'
                when 'active'
                    switch user.approval_state
                        when 'waiting'
                            if approvingUsers[user.id]
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

        $scope.doDeleteUser = (user)->
            user_name = user.handle_name
            user.$remove (data)->
                $scope.users.del user
                $state.go 'admin.user'
                Notify "「#{user_name}」さんを削除しました。", type: 'danger'
            , (err)->
                Notify "ユーザーの削除に失敗しました。", type: 'danger'

        $scope.deleteBtnLabel = ()->
            if $scope.deleting
                return "マジで削除する"
            else
                return '削除する'

        $scope.stopDeleting = ->
            $scope.deleting = false

        $scope.deleteUser = (user)->
            if $scope.deleting
                $scope.doDeleteUser user
            else
                $scope.deleting = true


