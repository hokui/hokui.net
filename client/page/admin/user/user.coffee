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
        url: '/{id:int}',
        views:
            'main@admin.user':
                templateUrl: '/page/admin/user/detail.html'
                controller: 'AdminUserDetailCtrl'


.controller 'AdminUserCtrl',
    ($scope, $http, $state, Notify, ResourceStore, Env, users, classYears) ->
        $scope.users = new ResourceStore users
        $scope.classYears = new ResourceStore classYears

        $scope.approvable = (user)->
            user.activation_state is 'active' and user.approval_state is 'waiting'

        $scope.getClassYearLabel = (user)->
            $scope.classYears.retrieve(user.class_year_id).year

        $scope.doApproveUser = (user, fake)->
            if not $scope.approvable(user)
                Notify 'すでに認証済みのユーザーです。', type: 'warn'

            onSuccess =(data)->
                user.approval_state = 'approved'
                Notify "「#{user.handle_name}」さんを認証しました。"

            onError =(err)->
                Notify 'ユーザーの認証に失敗しました。', type: 'danger'

            if not fake
                $http.post "#{api.apiRoot()}/users/#{user.id}/approve",
                    {}
                .success onSuccess
                .error onError
            else
                onSuccess()

.controller 'AdminUserListCtrl',
    ($scope, $templateCache, Notify, ResourceFilter, ResourceFieldSorter, ResourceSorter) ->
        $scope.idSorter = new ResourceSorter()

        classYearMap = $scope.classYears.getMap()
        $scope.classYearSorter = new ResourceSorter (a, b)->
            classYearMap[a.class_year_id].year > classYearMap[b.class_year_id].year

        $scope.handleNameSorter = new ResourceFieldSorter ['handle_name']
        $scope.fullNameSorter = new ResourceFieldSorter ['full_name']
        $scope.statusSorter = new ResourceFieldSorter ['admin', 'activation_state', 'approval_state']

        $scope.setSorter = $scope.idSorter

        userFilter = new ResourceFilter()

        $scope.stateFilter = new ResourceFilter
            parent: userFilter
            alternative: true

        .append new ResourceFilter
            label: 'メール承認待ち'
            filter: (user)->
                user.activation_state is 'pending'
        .append new ResourceFilter
            label: '管理人承認待ち'
            filter: (user)->
                user.activation_state is 'active' and user.approval_state is 'waiting'
        .append new ResourceFilter
            label: '管理者'
            filter: (user)->
                user.admin

        $scope.classYearFilter = new ResourceFilter
            parent: userFilter
            alternative: true

        _.forEach $scope.classYears.original, (cy)->
            $scope.classYearFilter.append new ResourceFilter
                label: "#{cy.year}期",
                filter: (user)->
                    user.class_year_id is cy.id

        $scope.nameFilter = new ResourceFilter
            parent: userFilter
            value: ''
            filter: (user)->
                exp = new RegExp @value
                hname = user.handle_name.match exp
                fname = user.full_name.match exp
                hname or fname


        $scope.users.setFilter userFilter


        approvingUsers = {}

        $scope.startApproveUser = (user)->
            approvingUsers[user.id] = true

        $scope.cancelApproveUser = (user)->
            approvingUsers[user.id] = false

        statusMap =
            admin:
                bariconClass: ['baricon--star', 'baricon--secondary']
                label: '管理者'
            active:
                bariconClass: ['baricon--heart', 'baricon--accent']
                label: '通常ユーザー'
            waiting:
                bariconClass: ['baricon--exclamation', 'baricon--primary', 'clickable']
                label: '管理人認証待ち'
                event: (user)->
                    $scope.startApproveUser user
            approve_processing:
                bariconClass: ['baricon--check', 'baricon--primary', 'clickable']
                label: 'もう一度クリックして認証'
                event: (user)->
                    $scope.doApproveUser user
                blur: (user)->
                    $scope.cancelApproveUser user
            pending:
                bariconClass: 'baricon--times'
                label: 'メール認証待ち'
            unknown:
                bariconClass: 'baricon--question'
                label: '不明な状態'

        $scope.userStatus = (user)->
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
                            if user.admin
                                t = 'admin'
                            else
                                t = 'active'
                        else
                            t = 'unknown'
                else
                    t = 'unknown'

            statusMap[t]

.controller 'AdminUserDetailCtrl',
    ($scope, $state, $stateParams, Notify, NotFound) ->
        user_id = $stateParams.id

        if not $scope.user = $scope.users.retrieve $stateParams.id
            NotFound()

        $scope.deleting = false
        $scope.doDeleteUser = (user)->
            user_name = user.handle_name
            user.$remove (data)->
                $scope.users.remove user
                $state.go 'admin.user'
                Notify "「#{user_name}」さんを削除しました。", type: 'danger'
            , (err)->
                Notify 'ユーザーの削除に失敗しました。', type: 'danger'


        $scope.stopDeleting = ->
            $scope.deleting = false

        $scope.deleteUser = (user)->
            if $scope.deleting
                $scope.doDeleteUser user
            else
                $scope.deleting = true


