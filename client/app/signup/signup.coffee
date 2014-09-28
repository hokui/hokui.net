'use strict'

angular.module @appName
.config ($stateProvider) ->
    $stateProvider
    .state 'signup',
        url: '/signup'
        templateUrl: '/app/signup/signup.html'
        controller: 'SignupCtrl'
        resolve:
            years: (ClassYear)->
                ClassYear.query().$promise

.controller 'SignupCtrl',
    ($scope, Auth, User, years, $state) ->
        $scope.user = new User()
        $scope.years = years

        $scope.performSignup = ()->
            $scope.user.$save {}, (data)->
                $state.go 'main'
            , (err)->
                console.log err

        ###*
        FOR DEVEPOPMENT
        ###
        $scope.user.birthday= "1990-01-01"
        $scope.user.class_year = 93
        $scope.user.email= "abe@ec.hokudai.ac.jp"
        $scope.user.email_mobile= "abe@example.com"
        $scope.user.family_name= "阿部"
        $scope.user.given_name= "高和"
        $scope.user.handle_name= "あべさん"
        $scope.user.password= "yaranaika"
        $scope.reenteredPassword = $scope.user.password
