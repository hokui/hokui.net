'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'profile',
        url: '/profile'
        views:
            '':
                templateUrl: '/page/profile/profile.html'
                controller: 'ProfileCtrl'
            'main@profile':
                templateUrl: '/page/profile/main.html'
                controller: 'ProfileMainCtrl'


        resolve:
            classYears: (ClassYear, ResourceStore)->
                ClassYear.query().$promise.then (data)->
                    new ResourceStore data
        data:
            restrict:
                role: 'user'
                error: '/profile 以下へアクセスするにはログインしてください。'
                next: 'login'
            title: '北医ネット - プロフィール'

    $stateProvider
    .state 'profile.edit',
        url: '/edit'
        views:
            'main@profile':
                templateUrl: '/page/profile/edit.html'
                controller: 'ProfileEditCtrl'


.controller 'ProfileCtrl',
    ($scope, classYears)->
        $scope.classYears = classYears

        $scope.getClassYearLabel = (user)->
            $scope.classYears.retrieve(user.class_year_id).year

.controller 'ProfileMainCtrl',
    ($scope, Auth)->
        $scope.showDetail = false
        $scope.user = Auth.user()


.controller 'ProfileEditCtrl',
    ($scope, Responsive, Auth, $state, Notify)->
        $scope.showDetail = false

        $scope.newUser = _.clone Auth.user()

        $scope.newUser.birthday = new Date $scope.newUser.birthday

        $scope.tooltipClass = ->
            'tooltip--left' : not Responsive.xs
            'tooltip--bottom': Responsive.xs

        $scope.saveProfile = (valid)->
            if valid
                Auth.updateProfile $scope.newUser
                .then ->
                    $state.go 'profile'
                    Notify 'プロフィールを更新しました。'
                , ->
                    Notify '入力にエラーがあります。', type: 'warn'
                    $scope.errors = err.data.errors
            else
                Notify '入力にエラーがあります。', type: 'warn'


