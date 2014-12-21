'use strict'

describe 'Restrict', ->

    loginAdmin = loginUser = null

    beforeEach ->

        angular.module 'RestrictTestModule', (->)
        .config ($stateProvider) ->
            $stateProvider
            .state 'not_restricted',
                url: '/not_restricted'
                template: '<h1>not restricted</1h>'

            .state 'user_page',
                url: '/user_page'
                template: '<h1>user page</1h>'
                data:
                    restrict:
                        role: 'user'
                        next: 'login_page'

            .state 'user_page.nested',
                url: '/nested'
                template: '<h1>nested user page</1h>'

            .state 'admin_page',
                url: '/admin_page'
                template: '<h1>admin page</1h>'
                data:
                    restrict:
                        role: 'admin'
                        error: 'admin only'

        .config (EnvProvider) ->
            EnvProvider.setApiPath '/api'

        .config (RestrictProvider) ->
            RestrictProvider.setNext 'redirect_to'

        module moduleCore, 'RestrictTestModule'

        inject ($httpBackend, Auth)->
            mockupAPI $httpBackend
            Auth.silentLogout()
            loginAdmin = getLoginAdminProc($httpBackend, Auth)
            loginUser = getLoginUserProc($httpBackend, Auth)

    afterEach inject (Auth)->
        Auth.silentLogout()


    it 'not restrict', inject (Restrict, $state)->
        expect($state.get('not_restricted').url).toBe '/not_restricted'

        result = Restrict $state.get 'not_restricted'
        expect(result.can).toBe true
        result = Restrict $state.get 'user_page'
        expect(result.can).toBe false
        expect(result.next).toBe 'login_page'
        result = Restrict $state.get 'user_page.nested'
        expect(result.can).toBe false
        expect(result.next).toBe 'login_page'
        result = Restrict $state.get 'admin_page'
        expect(result.can).toBe false
        expect(result.error).toBe 'admin only'

    it 'needs user level', inject (Restrict, $state, Auth)->
        loginUser(Auth)

        result = Restrict $state.get 'not_restricted'
        expect(result.can).toBe true
        result = Restrict $state.get 'user_page'
        expect(result.can).toBe true
        result = Restrict $state.get 'user_page.nested'
        expect(result.can).toBe true
        result = Restrict $state.get 'admin_page'
        expect(result.can).toBe false
        expect(result.next).toBe 'redirect_to'


    it 'needs admin level', inject (Restrict, $state, Auth)->
        loginAdmin(Auth)

        result = Restrict $state.get 'not_restricted'
        expect(result.can).toBe true
        result = Restrict $state.get 'user_page'
        expect(result.can).toBe true
        result = Restrict $state.get 'user_page.nested'
        expect(result.can).toBe true
        result = Restrict $state.get 'admin_page'
        expect(result.can).toBe true


