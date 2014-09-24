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

        $scope.showDetail = (user)->
            $state.go 'admin.user.detail', id: user.id

        $scope.getYear = (id)->
            IDRetrieve($scope.years, id).year


.controller 'AdminUserDetailCtrl',
    ($scope, User, $stateParams, $http, $state, IDRetrieve, $location) ->
        user_id = $stateParams.id

        $scope.user = IDRetrieve($scope.users, user_id)

        $scope.approvable =
            $scope.user.activation_state is 'active' and $scope.user.approval_state is 'waiting'

        $scope.approve = ->
            if not $scope.approvable
                console.log 'dont approve!!'

            $http.post "/api/users/#{$scope.user.id}/approve",
                {}
            .success (data)->
                $state.transitionTo 'admin.user', {},
                    reload: true
                    inherit: false
                    notify: true

