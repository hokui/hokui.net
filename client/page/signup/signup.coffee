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
            $scope.user.$save {}, (data)->
                $state.go 'main'
            , (err)->
                console.log err

        seed = Env.seed 'signup'
        if seed?
            $scope.user = seed
            $scope.reenteredPassword = $scope.user.password
        else
            $scope.user.class_year_id = years[0].id
