'use strict'

describe 'Auth', ->

    beforeEach ->
        angular.module 'AuthTestModule', (->)
        .config (TokenProvider)->
            TokenProvider.setStorageKey 'token'
            TokenProvider.setHeaderKey 'Access-Token'
            TokenProvider.setTokenPrefix ''

        .config (EnvProvider)->
            EnvProvider.setApiRoot '/api'

        module moduleCore, 'AuthTestModule'

        inject ($httpBackend, Auth)->
            mockupAPI $httpBackend
            Auth.silentLogout()

    afterEach ->
        inject ($httpBackend, Auth)->
            $httpBackend.verifyNoOutstandingExpectation()
            $httpBackend.verifyNoOutstandingRequest()
            Auth.silentLogout()

    it 'silent logout', inject ($httpBackend, Token, Auth)->
        Token.set 'ThisIsDummyToken', false

        Auth.silentLogout()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null
        expect(Token.get()).toBe ''


    it 'login fail', inject ($httpBackend, Token, Auth)->
        $httpBackend.expectPOST('/api/session')

        Auth.login
            email: 'not_authorized@hokudai.ac.jp'
            password: 'not_authorized'
        , false
        $httpBackend.flush()
        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null


    it 'admin login', inject ($httpBackend, Token, Auth)->
        $httpBackend.expectPOST('/api/session')

        Auth.login mocks.admin_credencials, false

        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.admin_user
        expect(Token.get()).toBe mocks.admin_token


        expect(Auth.can('admin')).toBe true
        expect(Auth.can(2)).toBe true
        expect(Auth.can('user')).toBe true
        expect(Auth.can(1)).toBe true
        expect(Auth.can('guest')).toBe true
        expect(Auth.can(0)).toBe true
        # defaultly needs 'user'
        expect(Auth.can()).toBe true


    it 'user login', inject ($httpBackend, Token, Auth)->
        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.admin_credencials, false
        $httpBackend.flush()

        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.user_credencials, false

        $httpBackend.flush()

        expect(Auth.active()).toBe(true)
        expect(Auth.user()).toEqual(mocks.user_user)
        expect(Token.get()).toBe(mocks.user_token)


        expect(Auth.can('admin')).toBe false
        expect(Auth.can(2)).toBe false
        expect(Auth.can('user')).toBe true
        expect(Auth.can(1)).toBe true
        expect(Auth.can('guest')).toBe true
        expect(Auth.can(0)).toBe true

        expect(Auth.can()).toBe true


    # HELPER SPEC
    it 'admin login helper', inject ($httpBackend, Token, Auth)->
        getLoginAdminProc($httpBackend, Auth)()
        expect(Auth.active()).toBe(true)
        expect(Auth.user()).toEqual(mocks.admin_user)
        expect(Token.get()).toBe(mocks.admin_token)


    # HELPER SPEC
    it 'user login helper', inject ($httpBackend, Token, Auth)->
        getLoginUserProc($httpBackend, Auth)()
        expect(Auth.active()).toBe(true)
        expect(Auth.user()).toEqual(mocks.user_user)
        expect(Token.get()).toBe(mocks.user_token)


    it 'logout', inject ($httpBackend, Token, Auth)->
        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.admin_credencials, false
        $httpBackend.flush()

        $httpBackend.expectDELETE('/api/session')
        Auth.logout()
        $httpBackend.flush()

        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual(null)
        expect(Token.get()).toBe('')

    it 'logout when token is unset', inject ($httpBackend, Token, Auth)->
        # if token is empty, Auth doesnt call API
        Auth.logout()

        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual(null)
        expect(Token.get()).toBe('')

        expect(Auth.can('admin')).toBe false
        expect(Auth.can(2)).toBe false
        expect(Auth.can('user')).toBe false
        expect(Auth.can(1)).toBe false
        expect(Auth.can('guest')).toBe true
        expect(Auth.can(0)).toBe true

        expect(Auth.can()).toBe false

    it 'check fail', inject ($httpBackend, Token, Auth)->
        # Need to set fake token because Auth.check() doesnt call API if token is empty
        Token.set 'ThisIsUnauthorizedTestToken', false

        $httpBackend.expectGET('/api/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null


    it 'check fail after token is changed', inject ($httpBackend, Token, Auth)->
        # token is invalid somehow after login
        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.admin_credencials, false
        $httpBackend.flush()

        Token.set 'ThisIsUnauthorizedTestToken', false

        $httpBackend.expectGET('/api/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null


    it 'check admin', inject ($httpBackend, Token, Auth)->
        Token.set mocks.admin_token, false

        $httpBackend.expectGET('/api/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.admin_user

    it 'check user', inject ($httpBackend, Token, Auth)->
        Token.set mocks.user_token, false

        $httpBackend.expectGET('/api/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.user_user



