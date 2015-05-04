'use strict'

describe 'Restrict', ->
    default_message = 'default message'
    RestrictProvider = null
    doLoginAsAdmin = doLoginAsUser = null

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        angular.module 'RestrictTestModule', [moduleCore]
        .config ($stateProvider)->
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
                        message: 'admin only'

        .config (RestrictProvider)->
            RestrictProvider.defaultNext 'home'
            RestrictProvider.defaultMessage default_message

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


    it 'level guest', inject ($state, Auth, Restrict)->
        result = Restrict.check $state.get 'home'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'profile'
        expect result.can
        .toBe false
        expect result.message
        .toBe default_message
        expect result.next
        .toBe 'login'

        result = Restrict.check $state.get 'profile.nested'
        expect result.can
        .toBe false
        expect result.message
        .toBe default_message
        expect result.next
        .toBe 'login'

        result = Restrict.check $state.get 'admin'
        expect result.can
        .toBe false
        expect result.message
        .toBe 'admin only'
        expect result.next
        .toBe 'home'


    it 'level user', inject ($state, Auth, Restrict)->
        doLoginAsUser()

        result = Restrict.check $state.get 'home'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'profile'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'profile.nested'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'admin'
        expect result.can
        .toBe false
        expect result.message
        .toBe 'admin only'
        expect result.next
        .toBe 'home'


    it 'level admin', inject ($state, Auth, Restrict)->
        doLoginAsAdmin()

        result = Restrict.check $state.get 'home'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'profile'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'profile.nested'
        expect result.can
        .toBe true

        result = Restrict.check $state.get 'admin'
        expect result.can
        .toBe true

