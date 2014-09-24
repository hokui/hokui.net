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
    ($scope, users, years) ->
        $scope.users = users
        $scope.years = years

.controller 'AdminUserListCtrl',
    ($scope, User, Token, $state, IDRetrieve) ->

        $scope.getYear = (id)->
            IDRetrieve($scope.years, id).year


.controller 'AdminUserDetailCtrl',
    ($scope, User, $stateParams, $http, $state, IDRetrieve, $location) ->
        user_id = $stateParams.id

        $scope.user = IDRetrieve($scope.users, user_id)

        $scope.approvable = (user)->
            user.activation_state is 'active' and user.approval_state is 'waiting'

        $scope.deleteUser = (user)->
            user.$remove (data)->
                $state.transitionTo 'admin.user', {},
                    reload: true
                    inherit: false
                    notify: true
            , (err)->
                console.log err
                console.log 'cant delete user'

        $scope.approve = (user)->
            if not $scope.approvable(user)
                console.log 'cant approve'

            $http.post "/api/users/#{$scope.user.id}/approve",
                {}
            .success (data)->
                $state.transitionTo 'admin.user', {},
                    reload: true
                    inherit: false
                    notify: true

