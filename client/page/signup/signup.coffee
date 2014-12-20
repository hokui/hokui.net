'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'signup',
        url: '/signup'
        templateUrl: '/page/signup/signup.html'
        controller: 'SignupCtrl'
        resolve:
            years: (ClassYear)->
                ClassYear.query().$promise

.controller 'SignupCtrl',
    ($scope, Auth, User, years, $state, Env) ->
        $scope.user = new User()
        $scope.years = years

        $scope.performSignup = ()->
            if $scope.reenteredPassword is $scope.user.password
                $scope.user.$save {}, (data)->
                    $state.go 'home'
                , (err)->
                    console.log err

        seed = Env.seed 'signup'
        if seed?
            angular.extend $scope.user, seed.user
            $scope.reenteredPassword = $scope.user.password

        $scope.user.birthday = new Date('1990/1/1')
        $scope.user.class_year_id = years[0].id
