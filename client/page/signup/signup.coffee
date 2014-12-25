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
    ($scope, Auth, User, years, $state, Env, Notify) ->
        $scope.user = new User()
        $scope.years = years
        $scope.errors = {}

        $scope.performSignup = (valid)->
            if valid
                $scope.user.$save {}, (data)->
                    $state.go 'home'
                    Notify 'ユーザー登録を受け付けました。本人確認のメールをお待ちください。', period: -1
                , (err)->
                    Notify '入力にエラーがあります。', type: 'warn'
                    $scope.errors = err.data.errors
            else
                Notify '入力にエラーがあります。', type: 'warn'


        seed = Env.seed 'signup'
        if seed?
            angular.extend $scope.user, seed.user
            $scope.reenteredPassword = $scope.user.password

        $scope.user.birthday = new Date('1990/1/1')
        $scope.user.class_year_id = years[0].id
