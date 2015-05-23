'use strict'

describe 'Token configuration', ->

    TokenProvider = null

    beforeEach ->
        window.localStorage.clear()
        window.sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

    afterEach ->
        window.localStorage.clear()
        window.sessionStorage.clear()


    it 'default', inject ->
        expect TokenProvider.headerKey()
        .toBe 'Authorization'
        expect TokenProvider.storageKey()
        .toBe 'token'
        expect TokenProvider.tokenPrefix()
        .toBe ''

        it 'settings', inject ($http, Token, webStorage)->
            expect Token.headerKey()
            .toBe 'Authorization'
            expect Token.storageKey()
            .toBe 'token'
            expect Token.tokenPrefix()
            .toBe ''

        it 'set/get', inject ($http, Token, webStorage)->
            expect Token.exists()
            .toBe false
            expect Token.empty()
            .toBe true

            # use session
            Token.set 'TEST_TOKEN', false

            expect Token.exists()
            .toBe true
            expect Token.empty()
            .toBe false

            expect Token.get()
            .toBe 'TEST_TOKEN'

            expect webStorage.session.get Token.storageKey()
            .toBe 'TEST_TOKEN'

            expect $http.defaults.headers.common['Authorization']
            .toBe 'TEST_TOKEN'

            Token.clear()

            expect Token.exists()
            .toBe false

            expect webStorage.session.get Token.storageKey()
            .toBe null


    it 'changed/use prefix', inject ->
        TokenProvider.headerKey 'hk'
        TokenProvider.storageKey 'sk'
        TokenProvider.tokenPrefix 'prefix'

        expect TokenProvider.headerKey()
        .toBe 'hk'
        expect TokenProvider.storageKey()
        .toBe 'sk'
        expect TokenProvider.tokenPrefix()
        .toBe 'prefix'

        inject ($http, Token, webStorage)->
            expect Token.headerKey()
            .toBe 'hk'
            expect Token.storageKey()
            .toBe 'sk'
            expect Token.tokenPrefix()
            .toBe 'prefix'

            # use local
            Token.set 'TEST_TOKEN', true

            expect Token.get()
            .toBe 'TEST_TOKEN'

            expect webStorage.local.get Token.storageKey()
            .toBe 'TEST_TOKEN'

            expect $http.defaults.headers.common['hk']
            .toBe 'prefix TEST_TOKEN'

            Token.clear()

            expect Token.exists()
            .toBe false

            expect webStorage.local.get Token.storageKey()
            .toBe null



describe 'Token store', ->
    storageKey = 'token'
    TokenProvider = null
    TEST_TOKEN_IN_LOCAL = 'TEST_TOKEN_IN_LOCAL'
    TEST_TOKEN_IN_SESSION = 'TEST_TOKEN_IN_SESSION'

    beforeEach ->
        window.localStorage.clear()
        window.sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

    afterEach ->
        window.localStorage.clear()
        window.sessionStorage.clear()

    it 'from local', ->
        window.localStorage.setItem storageKey, JSON.stringify TEST_TOKEN_IN_LOCAL

        inject ->
            TokenProvider.storageKey storageKey

            inject ($http, Token, webStorage)->
                expect Token.get()
                .toBe TEST_TOKEN_IN_LOCAL

                expect $http.defaults.headers.common[Token.headerKey()]
                .toBe TEST_TOKEN_IN_LOCAL

    it 'from session', ->
        window.sessionStorage.setItem storageKey, JSON.stringify TEST_TOKEN_IN_SESSION

        inject ->
            TokenProvider.storageKey storageKey

            inject ($http, Token, webStorage)->
                expect Token.get()
                .toBe TEST_TOKEN_IN_SESSION

                expect $http.defaults.headers.common[Token.headerKey()]
                .toBe TEST_TOKEN_IN_SESSION


    it 'from session(both local/session have token)', ->
        window.localStorage.setItem storageKey, JSON.stringify TEST_TOKEN_IN_LOCAL
        window.sessionStorage.setItem storageKey, JSON.stringify TEST_TOKEN_IN_SESSION

        inject ->
            TokenProvider.storageKey storageKey

            inject ($http, Token, webStorage)->
                expect Token.get()
                .toBe TEST_TOKEN_IN_SESSION

                expect $http.defaults.headers.common[Token.headerKey()]
                .toBe TEST_TOKEN_IN_SESSION


describe 'Token store(session is not supported)', ->
    _sessionStorageSetItem = null

    beforeEach ->
        _sessionStorageSetItem = window.sessionStorage.setItem
        window.sessionStorage.setItem = undefined

        window.localStorage.clear()
        window.sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]

        module 'TokenTestModule'

        inject -> undefined

    afterEach ->
        window.sessionStorage.setItem = _sessionStorageSetItem

        window.localStorage.clear()
        window.sessionStorage.clear()

    it 'keep token to local', inject ($http, Token, webStorage)->
        Token.set 'TEST_TOKEN', true

        expect webStorage.local.get Token.storageKey()
        .toBe 'TEST_TOKEN'

    it 'save token to memory', inject ($http, Token, webStorage)->
        Token.set 'TEST_TOKEN'

        expect webStorage.memory.get Token.storageKey()
        .toBe 'TEST_TOKEN'


describe 'Token store(local is not supported)', ->
    TokenProvider = null
    _localStorageSetItem = null

    beforeEach ->
        _localStorageSetItem = window.localStorage.setItem
        window.localStorage.setItem = undefined

        window.localStorage.clear()
        window.sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]

        module 'TokenTestModule'

        inject -> undefined

    afterEach ->
        window.localStorage.setItem = _localStorageSetItem

        window.localStorage.clear()
        window.sessionStorage.clear()

    it 'keep token to local', inject ($http, Token, webStorage)->
        Token.set 'TEST_TOKEN', true

        expect webStorage.session.get Token.storageKey()
        .toBe 'TEST_TOKEN'

    it 'save token to memory', inject ($http, Token, webStorage)->
        Token.set 'TEST_TOKEN'

        expect webStorage.session.get Token.storageKey()
        .toBe 'TEST_TOKEN'




describe 'Token store(local/session are not supported)', ->
    _localStorageSetItem = null
    _sessionStorageSetItem = null

    beforeEach ->
        _localStorageSetItem = window.localStorage.setItem
        _sessionStorageSetItem = window.sessionStorage.setItem
        window.localStorage.setItem = undefined
        window.sessionStorage.setItem = undefined

        window.localStorage.clear()
        window.sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]

        module 'TokenTestModule'

        inject -> undefined

    afterEach ->
        window.localStorage.setItem = _localStorageSetItem
        window.sessionStorage.setItem = _sessionStorageSetItem

        window.localStorage.clear()
        window.sessionStorage.clear()

    it 'keep token to local', inject ($http, Token, webStorage)->
        Token.set 'TEST_TOKEN', true

        expect webStorage.memory.get Token.storageKey()
        .toBe 'TEST_TOKEN'

    it 'save token to memory', inject ($http, Token, webStorage)->
        Token.set 'TEST_TOKEN'

        expect webStorage.memory.get Token.storageKey()
        .toBe 'TEST_TOKEN'
