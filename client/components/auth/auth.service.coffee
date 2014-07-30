'use strict'

angular.module('hokuiApp').factory('Auth', [
    '$location', '$http', '$rootScope', '$q', 'Token',
    ($location, $http, $rootScope, $q, Token) ->
        current:
            active: false
            user : {}

        login: (user) ->
            deferred = $q.defer()
            $http.post('/api/session',
                email: user.email
                password: user.password
            ).success((data) =>
                Token.set(data.token)
                # note:
                # 成功したところで必要な情報は揃わないので改めて@check()を呼ぶ。
                # profileを叩くまでが一連のlogin処理となる。しかし多段promise。汚い。
                console.log('You success successfully logging in. Automatically call GET /api/users/profile..')
                @check().then (data)=>
                    deferred.resolve @current
                    $rootScope.$broadcast 'authorized', message: 'You logged in.'
            ).error((err) ->
                deferred.reject err
            )
            deferred.promise

        logout: (callback) ->
            deferred = $q.defer()
            # note: backend still needs url query params
            if Token.get()
                $http.delete('/api/session', {}
                ).success((data) =>
                    @silentLogout()
                    $rootScope.$broadcast 'deauthorized', message: 'You logged out.'
                    deferred.resolve()
                ).error((err) =>
                    # 失敗しても$httpでerrorをのhookしてsileintLogoutが呼ばれる
                    # @silentLogout()
                    # てかログアウトの失敗ってなんだ？失敗する必要がどこにあるんですか……
                    deferred.reject err
                )
            else
                # もちろんTokenがなければそのままログアウト。validじゃなきゃ鯖にもTokenは存在しないからね。
                @silentLogout()
                deferred.resolve()

            deferred.promise

        silentLogout: ()->
            Token.clear()
            @current.active = false
            @current.user = {}


        check: (callback) ->
            deferred = $q.defer()
            if Token.get()
                $http.get('/api/users/profile', {}
                ).success((data) =>
                    @current.active = true
                    @current.user = data.user
                    deferred.resolve @current
                ).error((err) =>
                    @current.active = false
                    @current.user = {}
                    deferred.reject @current
                )
            else
                @current.active = false
                @current.user = {}
                deferred.reject @current

            deferred.promise


]).run(['Auth', 'Token', '$location', (Auth, Token, $location)->
    # memo:
    # トップに飛んだら必ずloginに飛ばすかどうかは別問題
    # あくまですべてinitされてから、Tokenに対するAuth.currentの状態を更新するためのもの
    # この処理ありきでController側は安心してAuth.currentを認証状態のチェックに使うことが
    # 可能となる
    Auth.check()

])

