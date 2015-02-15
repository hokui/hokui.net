'use strict'

describe 'Restrict', ->
    default_error = 'default error message'
    RestrictProvider = null
    doLoginAsAdmin = doLoginAsUser = null

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        angular.module 'RestrictTestModule', [moduleCore]
        .config ($stateProvider) ->
            $stateProvider
            .state 'home',
                url: '/home'

            .state 'profile',
                url: '/profile'
                data:
                    restrict:
                        role: 'user'
                        next: 'login'

            .state 'profile.nested',
                url: '/nested'

            .state 'admin',
                url: '/admin'
                data:
                    restrict:
                        role: 'admin'
                        next: 'home'
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
            RestrictProvider.setNext 'home'
            RestrictProvider.setError default_error


        it 'level guest', inject ($state, Auth, Restrict)->
            result = Restrict $state.get 'home'
            expect result.can
            .toBe true

            result = Restrict $state.get 'profile'
            expect result.can
            .toBe false
            expect result.error
            .toBe default_error
            expect result.next
            .toBe 'login'

            result = Restrict $state.get 'profile.nested'
            expect result.can
            .toBe false
            expect result.error
            .toBe default_error
            expect result.next
            .toBe 'login'

            result = Restrict $state.get 'admin'
            expect result.can
            .toBe false
            expect result.error
            .toBe 'admin only'
            expect result.next
            .toBe 'home'


        it 'level user', inject ($state, Auth, Restrict)->
            doLoginAsUser()

            result = Restrict $state.get 'home'
            expect result.can
            .toBe true

            result = Restrict $state.get 'profile'
            expect result.can
            .toBe true

            result = Restrict $state.get 'profile.nested'
            expect result.can
            .toBe true

            result = Restrict $state.get 'admin'
            expect result.can
            .toBe false
            expect result.error
            .toBe 'admin only'
            expect result.next
            .toBe 'home'


        it 'level admin', inject ($state, Auth, Restrict)->
            doLoginAsAdmin()

            result = Restrict $state.get 'home'
            expect result.can
            .toBe true

            result = Restrict $state.get 'profile'
            expect result.can
            .toBe true

            result = Restrict $state.get 'profile.nested'
            expect result.can
            .toBe true

            result = Restrict $state.get 'admin'
            expect result.can
            .toBe true

