'use strict'

describe 'Auth', ->
    $httpBackend = Token = Auth = null
    doLoginAsAdmin = doLoginAsUser = null

    beforeEach ->
        window.localStorage.clear()
        window.sessionStorage.clear()

        angular.module 'AuthTestModule', [moduleCore]
        .config (TokenProvider)->
            TokenProvider.storageKey 'token'
            TokenProvider.headerKey 'Access-Token'
            TokenProvider.tokenPrefix ''
        .config (EnvProvider)->
            EnvProvider.setApiRoot '/api'

        module 'AuthTestModule'

        inject (_$httpBackend_, _Token_, _Auth_)->
            $httpBackend = _$httpBackend_
            Token = _Token_
            Auth = _Auth_

        doLoginAsAdmin = getLoginAsAdminProc $httpBackend, Auth
        doLoginAsUser = getLoginAsUserProc $httpBackend, Auth

        mockupAPI $httpBackend
        Auth.silentLogout()

    afterEach ->
        window.localStorage.clear()
        window.sessionStorage.clear()

        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()
        Auth.silentLogout()


    it 'silent logout', ->
        Token.set 'ThisIsDummyToken', false

        expect Token.empty()
        .toBe false
        expect Auth.active()
        .toBe false
        expect Auth.user()
        .toBe null

        Auth.silentLogout()

        expect Token.empty()
        .toBe true


    it 'login fail', ->
        $httpBackend.expectPOST '/api/session'

        Auth.login
            email: 'not_authorized@hokudai.ac.jp'
            password: 'not_authorized'
        , false
        $httpBackend.flush()

        expect Auth.active()
        .toBe false
        expect Auth.user()
        .toBe null


    it 'login admin', ->
        doLoginAsAdmin()

        expect Auth.active()
        .toBe true
        expect Auth.user()
        .toEqual mocks.admin_user
        expect Token.get()
        .toBe mocks.admin_token


    it 'login user', ->
        doLoginAsUser()

        expect Auth.active()
        .toBe true
        expect Auth.user()
        .toEqual mocks.user_user
        expect Token.get()
        .toBe mocks.user_token


    describe 'roles', ->
        rolesByStr = rolesByInt = null
        beforeEach ->
            rolesByStr = ->
                _.map ['admin', 'user', 'guest'], _.bind Auth.can, Auth
            rolesByInt = ->
                _.map [2, 1, undefined, 0], _.bind Auth.can, Auth


        it 'admin', ->
            doLoginAsAdmin()

            expect rolesByStr()
            .toEqual [true, true, true]
            expect rolesByInt()
            .toEqual [true, true, true, true]


        it 'user', ->
            doLoginAsUser()

            expect rolesByStr()
            .toEqual [false, true, true]
            expect rolesByInt()
            .toEqual [false, true, true, true]


        it 'guest', ->
            Auth.silentLogout()

            expect rolesByStr()
            .toEqual [false, false, true]
            expect rolesByInt()
            .toEqual [false, false, false, true]


    it 'logout', ->
        doLoginAsUser()

        $httpBackend.expectDELETE '/api/session'
        Auth.logout()
        $httpBackend.flush()

        expect Auth.active()
        .toBe false
        expect Auth.user()
        .toBe null
        expect Token.empty()
        .toBe true


    it 'logout when token is unset', ->
        Auth.logout()

        expect Auth.active()
        .toBe false
        expect Auth.user()
        .toBe null
        expect Token.empty()
        .toBe true


    it 'check without token', ->
        doLoginAsUser()

        Token.clear()

        Auth.check()

        expect Auth.active()
        .toBe false
        expect Auth.user()
        .toBe null


    it 'check fail', ->
        Token.set 'ThisIsUnauthorizedTestToken', false

        $httpBackend.expectGET '/api/profile'
        Auth.check()
        $httpBackend.flush()

        expect Auth.active()
        .toBe false
        expect Auth.user()
        .toBe null


    it 'check admin', ->
        Token.set mocks.admin_token, false

        $httpBackend.expectGET '/api/profile'
        Auth.check()
        $httpBackend.flush()

        expect Auth.active()
        .toBe true
        expect Auth.user()
        .toEqual mocks.admin_user


    it 'check user', ->
        Token.set mocks.user_token, false

        $httpBackend.expectGET '/api/profile'
        Auth.check()
        $httpBackend.flush()

        expect Auth.active()
        .toBe true
        expect Auth.user()
        .toEqual mocks.user_user


describe 'AuthChecker', ->
    AuthCheckerProvider = null

    beforeEach ->
        angular.module 'AuthCheckerTestModule', [moduleCore]
        .config ($stateProvider)->
            $stateProvider
            .state 'fake',
                url: '/fake'
        .config (TokenProvider)->
            TokenProvider.storageKey 'token'
            TokenProvider.headerKey 'Access-Token'
            TokenProvider.tokenPrefix ''

        module 'AuthCheckerTestModule'

    afterEach ->
        inject ($httpBackend, Auth)->
            $httpBackend.verifyNoOutstandingExpectation()
            $httpBackend.verifyNoOutstandingRequest()
            Auth.silentLogout()


    it 'configuration', ->
        angular.module 'AuthCheckerTestModule'
        .config (_AuthCheckerProvider_)->
            AuthCheckerProvider = _AuthCheckerProvider_
            AuthCheckerProvider.altStateChangeStart '$event'

        inject ->
            expect AuthCheckerProvider.altStateChangeStart()
            .toBe '$event'

            inject (AuthChecker)->
                expect AuthChecker.altStateChangeStart()
                .toBe '$event'


    it 'enabled false', ->
        angular.module 'AuthCheckerTestModule'
        .config (_AuthCheckerProvider_)->
            AuthCheckerProvider = _AuthCheckerProvider_
            AuthCheckerProvider.enabled false

        inject ->
            expect AuthCheckerProvider.altStateChangeStart()
            .toBe AuthCheckerProvider.defaultAltStateChangeStart()

            expect AuthCheckerProvider.enabled()
            .toBe false

            inject ($state, $httpBackend, Token, Auth, AuthChecker, $rootScope)->
                mockupAPI $httpBackend

                expect AuthChecker.enabled()
                .toBe false

                eventEmitted = false
                $rootScope.$on AuthChecker.altStateChangeStart(), ->
                    eventEmitted = true

                Token.set mocks.admin_token, false

                $state.go 'fake'

                expect eventEmitted
                .toBe false

                expect Auth.active()
                .toBe false


    it 'enabled true', ->
        angular.module 'AuthCheckerTestModule'
        .config (_AuthCheckerProvider_)->
            AuthCheckerProvider = _AuthCheckerProvider_
            AuthCheckerProvider.enabled true

        inject ->
            expect AuthCheckerProvider.enabled()
            .toBe true

            inject ($state, $httpBackend, Token, Auth, AuthChecker, $rootScope)->
                mockupAPI $httpBackend

                expect AuthChecker.enabled()
                .toBe true

                eventEmitted = false
                $rootScope.$on AuthChecker.altStateChangeStart(), ->
                    eventEmitted = true

                Token.set mocks.admin_token, false

                $httpBackend.expectGET '/api/profile'
                $state.go 'fake'
                $httpBackend.flush()

                expect Auth.active()
                .toBe true

                expect eventEmitted
                .toBe true


    it 'stateChange is prevented', ->
        angular.module 'AuthCheckerTestModule'
        .config (_AuthCheckerProvider_)->
            AuthCheckerProvider = _AuthCheckerProvider_

            # default false
            expect AuthCheckerProvider.enabled()
            .toBe false

            AuthCheckerProvider.enabled true


        inject ($state, $httpBackend, Token, Auth, AuthChecker, $rootScope)->
            mockupAPI $httpBackend

            $rootScope.$on AuthChecker.altStateChangeStart(), (ev)->
                ev.preventDefault()

            # when token is empty, not calling api
            $state.go 'fake'

            expect $state.current.name
            .not.toBe 'fake'
