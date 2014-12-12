'use strict'

describe 'Auth', ->

    Auth = $httpBackend = $http = Token = StorageType = null

    beforeEach ->

        angular.module 'AuthTestModule', (->)
        .config (TokenProvider)->
            TokenProvider.setStorageKey 'token'
            TokenProvider.setHeaderKey 'Access-Token'
            TokenProvider.setTokenPrefix ''

        module moduleCore, 'AuthTestModule'

        inject ($injector)->
            $httpBackend = $injector.get '$httpBackend'
            $http = $injector.get '$http'
            Auth = $injector.get 'Auth'
            Token = $injector.get 'Token'
            StorageType = $injector.get 'StorageType'

            mockupAPI $httpBackend

        # CLEAR CREDENCIALS
        Auth.silentLogout()


    afterEach ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()
        # CLEAR CREDENCIALS
        Auth.silentLogout()



    it 'silent logout', ->
        Token.set 'ThisIsDummyToken', StorageType.memory

        Auth.silentLogout()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null
        expect(Token.get()).toBe ''


    it 'login fail', ->
        $httpBackend.expectPOST('/api/session')

        Auth.login
            email: 'not_authorized@hokudai.ac.jp'
            password: 'not_authorized'
        , false
        $httpBackend.flush()
        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null


    it 'admin login', ->
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


    it 'user login', ->
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
    it 'admin login helper', ->
        getLoginAdminProc($httpBackend, Auth)()
        expect(Auth.active()).toBe(true)
        expect(Auth.user()).toEqual(mocks.admin_user)
        expect(Token.get()).toBe(mocks.admin_token)


    # HELPER SPEC
    it 'user login helper', ->
        getLoginUserProc($httpBackend, Auth)()
        expect(Auth.active()).toBe(true)
        expect(Auth.user()).toEqual(mocks.user_user)
        expect(Token.get()).toBe(mocks.user_token)


    it 'logout', ->
        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.admin_credencials, false
        $httpBackend.flush()


        $httpBackend.expectDELETE('/api/session')
        Auth.logout()
        $httpBackend.flush()

        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual(null)
        expect(Token.get()).toBe('')

    it 'logout when token is unset', ->
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

    it 'check fail', ->
        # Need to set fake token cuz Auth.check() doesnt call API if token is empty
        Token.set 'ThisIsUnauthorizedTestToken', StorageType.memory

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null


    it 'check fail after token is changed', ->
        # token is invalid somehow after login
        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.admin_credencials, false
        $httpBackend.flush()

        Token.set 'ThisIsUnauthorizedTestToken', StorageType.memory

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual null


    it 'check admin', ->
        # WITH ADMIN TOKEN
        Token.set mocks.admin_token, StorageType.memory

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.admin_user

    it 'check user', ->
        # WITH USER TOKEN
        Token.set mocks.user_token, StorageType.memory

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.user_user



