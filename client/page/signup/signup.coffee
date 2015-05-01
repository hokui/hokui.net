'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'signup',
        url: '/signup'
        templateUrl: '/page/signup/signup.html'
        controller: 'SignupCtrl'
        resolve:
            classYears: (ClassYear)->
                ClassYear.query().$promise
        data:
            title: '北医ネット - ユーザー登録'

.controller 'SignupCtrl',
    ($scope, Auth, User, classYears, $state, Env, Notify, Responsive) ->
        $scope.user = new User()
        $scope.classYears = classYears
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

        $scope.tooltipClass = ->
            'tooltip--left' : not Responsive.xs
            'tooltip--bottom': Responsive.xs

        seed = Env.seed 'signup'
        if seed?
            _.assign $scope.user, seed.user
            $scope.reenteredPassword = $scope.user.password

        nowYear = (new Date()).getFullYear()
        $scope.user.birthday = new Date "#{nowYear-19}/4/1"
        $scope.user.class_year_id = classYears?[classYears.length-1]?.id


