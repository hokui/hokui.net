'use strict'

describe 'auth service', ->

    Auth = $httpBackend = $http = Token = null

    beforeEach ->

        angular.module 'AuthTestModule', (->)
        .config (TokenProvider)->
            TokenProvider.storageKey 'token'
            TokenProvider.tokenKey 'Access-Token'
            TokenProvider.tokenPrefix ''

        module serviceName, 'AuthTestModule'

        inject ($injector)->
            $httpBackend = $injector.get '$httpBackend'
            $http = $injector.get '$http'
            Auth = $injector.get 'Auth'
            Token = $injector.get 'Token'

            mockupAPI $httpBackend

        # CLEAR CREDENCIALS
        Auth.silentLogout()


    afterEach ->
        $httpBackend.verifyNoOutstandingExpectation()
        $httpBackend.verifyNoOutstandingRequest()
        # CLEAR CREDENCIALS
        Auth.silentLogout()



    it 'silent logout', ->
        Token.set 'ThisIsDummyToken'

        Auth.silentLogout()

        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual({})
        expect(Token.get()).toBe('')


    it 'login fail', ->
        $httpBackend.expectPOST('/api/session')

        Auth.login
            email: 'not_authorized@hokudai.ac.jp'
            password: 'not_authorized'
        $httpBackend.flush()
        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual({})


    it 'admin login', ->
        $httpBackend.expectPOST('/api/session')

        Auth.login mocks.admin_credencials

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
        Auth.login mocks.admin_credencials
        $httpBackend.flush()

        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.user_credencials

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
        Auth.login mocks.admin_credencials
        $httpBackend.flush()


        $httpBackend.expectDELETE('/api/session')
        Auth.logout()
        $httpBackend.flush()

        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual({})
        expect(Token.get()).toBe('')

        # if token is empty, Auth doesnt call API
        Auth.logout()

        expect(Auth.active()).toBe(false)
        expect(Auth.user()).toEqual({})
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
        Token.set('ThisIsUnauthorizedTestToken')

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual {}


        ###*
        TOKEN IS INVALID SOMEHOW AFTER LOGIN
        ###
        $httpBackend.expectPOST('/api/session')
        Auth.login mocks.admin_credencials
        $httpBackend.flush()


        Token.set 'ThisIsUnauthorizedTestToken'

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe false
        expect(Auth.user()).toEqual {}


    it 'check admin', ->
        # WITH ADMIN TOKEN
        Token.set mocks.admin_token

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.admin_user

    it 'check user', ->
        # WITH USER TOKEN
        Token.set mocks.user_token

        $httpBackend.expectGET('/api/users/profile')
        Auth.check()
        $httpBackend.flush()

        expect(Auth.active()).toBe true
        expect(Auth.user()).toEqual mocks.user_user



