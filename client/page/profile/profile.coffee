'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'profile',
        url: '/profile'
        templateUrl: '/page/profile/profile.html'
        controller: 'ProfileCtrl'
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

.controller 'ProfileCtrl',
    ($scope, Auth, classYears) ->
        $scope.classYears = classYears
        $scope.user = Auth.user()

        $scope.getClassYearLabel = (user)->
            $scope.classYears.retrieve(user.class_year_id).year
