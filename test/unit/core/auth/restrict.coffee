'use strict'

describe 'Restrict', ->
    RestrictProvider = null
    doLoginAsAdmin = doLoginAsUser = null

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        angular.module 'RestrictTestModule', [moduleCore]
        .config ($stateProvider) ->
            $stateProvider
            .state 'not_restricted',
                url: '/not_restricted'

            .state 'user_page',
                url: '/user_page'
                data:
                    restrict:
                        role: 'user'
                        next: 'login_page'

            .state 'user_page.nested',
                url: '/nested'

            .state 'admin_page',
                url: '/admin_page'
                data:
                    restrict:
                        role: 'admin'
                        error: 'admin only'

        .config (_RestrictProvider_) ->
            RestrictProvider = _RestrictProvider_

        module 'RestrictTestModule'

        inject ($httpBackend, Auth)->
            mockupAPI $httpBackend
            Auth.silentLogout()
            doLoginAsAdmin = getLoginAsAdminProc $httpBackend, Auth
            doLoginAsUser = getLoginAsUserProc $httpBackend, Auth

    afterEach ->
        localStorage.clear()
        sessionStorage.clear()

        inject (Auth)->
            Auth.silentLogout()

    it 'not provided default page to redirect', ->
        inject ($injector)->
            try
                $injector.get 'Restrict'

                expect true
                .toBe false
            catch e
                expect true
                .toBe true

    describe 'configured', ->
        beforeEach ->
            RestrictProvider.setNext 'home_page'
            RestrictProvider.setError 'default message'

        it 'level guest', inject ($state, Auth, Restrict)->
            result = Restrict $state.get 'not_restricted'
            expect result.can
            .toBe true

            result = Restrict $state.get 'user_page'
            expect result.can
            .toBe false
            expect result.next
            .toBe 'login_page'

            result = Restrict $state.get 'user_page.nested'
            expect result.can
            .toBe false
            expect result.next
            .toBe 'login_page'
            expect result.error
            .toBe 'default message'

            result = Restrict $state.get 'admin_page'
            expect result.can
            .toBe false
            expect result.error
            .toBe 'admin only'

        it 'level user', inject ($state, Auth, Restrict)->
            doLoginAsUser()

            result = Restrict $state.get 'not_restricted'
            expect result.can
            .toBe true

            result = Restrict $state.get 'user_page'
            expect result.can
            .toBe true

            result = Restrict $state.get 'user_page.nested'
            expect result.can
            .toBe true

            result = Restrict $state.get 'admin_page'
            expect result.can
            .toBe false
            expect result.next
            .toBe 'home_page'

        it 'level admin', inject ($state, Auth, Restrict)->
            doLoginAsAdmin()

            result = Restrict $state.get 'not_restricted'
            expect result.can
            .toBe true

            result = Restrict $state.get 'user_page'
            expect result.can
            .toBe true

            result = Restrict $state.get 'user_page.nested'
            expect result.can
            .toBe true

            result = Restrict $state.get 'admin_page'
            expect result.can
            .toBe true


