'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'reactivation',
        url: '/reactivation'
        templateUrl: '/page/reactivation/reactivation.html'
        controller: 'ReactivationCtrl'

        data:
            title: '北医ネット - 再認証リクエスト'

.controller 'ReactivationCtrl',
    ($scope, $state, $http, Env, Notify)->
        $scope.email = ''

        $scope.performReactivation = (valid)->
            if valid
                $http.post "#{Env.apiRoot()}/activation_request",
                    email: $scope.email
                .success ->
                    $state.go 'home'
                    Notify '認証メールの再送信リクエストを受け付けました。メールが届くまでお待ちください。', period: -1
                .error (err)->
                    if err.approval_state is 'approved'
                        Notify 'メール認証はすでに完了しています。ログインできない場合は管理人の承認をお待ちください。',
                            period: -1
                            type: 'warn'
                    else
                        Notify '登録されていないメールアドレスです。先にユーザー登録をしてください。',
                            period: -1
                            type: 'warn'
            else
                Notify '入力にエラーがあります。', type: 'warn'
