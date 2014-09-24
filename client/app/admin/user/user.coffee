'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.user',
        url: '/user',
        views:
            'main@admin':
                templateUrl: '/app/admin/user/user.html'
                controller: 'AdminUserCtrl'
                resolve:
                    users: (User)->
                        User.query().$promise
                    years: (ClassYear)->
                        ClassYear.query().$promise

            'main@admin.user':
                templateUrl: '/app/admin/user/list.html'
                controller: 'AdminUserListCtrl'

    .state 'admin.user.detail',
        url: '/:id',
        views:
            'main@admin.user':
                templateUrl: '/app/admin/user/detail.html'
                controller: 'AdminUserDetailCtrl'


.controller 'AdminUserCtrl',
    ($scope, $http, $state, IDRetrieve, users, years) ->
        $scope.users = users
        $scope.years = years

        $scope.approvable = (user)->
            user.activation_state is 'active' and user.approval_state is 'waiting'

        $scope.getYear = (user)->
            IDRetrieve($scope.years, user.class_year_id).year

        $scope.approveUser = (user)->
            if not $scope.approvable(user)
                console.log 'cant approve'

            $http.post "/api/users/#{user.id}/approve",
                {}
            .success (data)->
                user.approval_state = 'approved'
                if user.approve_processing?
                    delete user['approve_processing']


        $scope.deleteUser = (user)->
            user.$remove (data)->
                $state.transitionTo 'admin.user', {},
                    reload: true
                    inherit: false
                    notify: true
            , (err)->
                console.log err
                console.log 'cant delete user'

.controller 'AdminUserListCtrl',
    ($scope, $templateCache) ->
        # activation_state
        #   pending : メール認証待ち
        #   active  : メール認証済
        # approval_state
        #   waiting : 管理人承認待ち
        #   approved: active!

        $scope.processApprove = (user)->
            user.approve_processing = true

        $scope.status = (user)->
            t = ''
            switch user.activation_state
                when 'pending'
                    t = 'pending'
                when 'active'
                    switch user.approval_state
                        when 'waiting'
                            if user.approve_processing?
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
    ($scope, $stateParams, IDRetrieve) ->
        user_id = $stateParams.id

        $scope.user = IDRetrieve($scope.users, user_id)


