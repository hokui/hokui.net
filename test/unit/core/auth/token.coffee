'use strict'

describe 'Token configuration', ->

    TokenProvider = null

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

        inject ->

    afterEach ->
        localStorage.clear()
        sessionStorage.clear()


    it 'default', ->
        expect TokenProvider.getHeaderKey()
        .toBe 'Authorization'
        expect TokenProvider.getStorageKey()
        .toBe 'token'
        expect TokenProvider.getTokenPrefix()
        .toBe 'token'

        inject (Token)->
            expect Token.getHeaderKey()
            .toBe 'Authorization'
            expect Token.getStorageKey()
            .toBe 'token'
            expect Token.getTokenPrefix()
            .toBe 'token'


    it 'changed', ->
        TokenProvider.setHeaderKey 'hk'
        expect TokenProvider.getHeaderKey()
        .toBe 'hk'

        TokenProvider.setStorageKey 'sk'
        expect TokenProvider.getStorageKey()
        .toBe 'sk'

        TokenProvider.setTokenPrefix 'prefix'
        expect TokenProvider.getTokenPrefix()
        .toBe 'prefix'

        inject (Token)->
            expect Token.getHeaderKey()
            .toBe 'hk'
            expect Token.getStorageKey()
            .toBe 'sk'
            expect Token.getTokenPrefix()
            .toBe 'prefix'


    it 'use default', ->
        TokenProvider.setHeaderKey ''
        TokenProvider.setStorageKey ''
        TokenProvider.setTokenPrefix 1

        inject (Token)->
            expect Token.getHeaderKey()
            .toBe 'Authorization'
            expect Token.getStorageKey()
            .toBe 'token'
            expect Token.getTokenPrefix()
            .toBe 'token'


    it 'prefix', ->
        TokenProvider.setHeaderKey 'hk'
        TokenProvider.setTokenPrefix 'prefix'

        inject (Token, $http)->
            Token.set 'token'
            expect Token.get()
            .toBe 'token'
            expect $http.defaults.headers.common['hk']
            .toBe 'prefix token'


describe 'Token(local/session both supported)', ->
    TokenProvider = null

    header_key = 'HEADER_KEY'
    storage_key = 'STORAGE_KEY'

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

        inject (webStorage)->
            webStorage.memory.clear()

    afterEach ->
        localStorage.clear()
        sessionStorage.clear()


    describe 'configured', ->
        Token = $http = webStorage = null
        beforeEach ->
            TokenProvider.setStorageKey storage_key
            TokenProvider.setHeaderKey header_key
            TokenProvider.setTokenPrefix ''
            inject (_Token_, _$http_, _webStorage_)->
                Token = _Token_
                $http = _$http_
                webStorage = _webStorage_


        it 'set token keeping', ->
            expect Token.empty()
            .toBe true
            expect Token.exists()
            .toBe false

            Token.set 'keeping', true

            expect Token.empty()
            .toBe false
            expect Token.exists()
            .toBe true
            expect Token.get()
            .toBe 'keeping'
            expect $http.defaults.headers.common[header_key]
            .toBe 'keeping'
            expect webStorage.local.get storage_key
            .toBe 'keeping'


        it 'set token not keeping', ->
            expect Token.empty()
            .toBe true
            expect Token.exists()
            .toBe false

            Token.set 'notkeeping', false

            expect Token.empty()
            .toBe false
            expect Token.exists()
            .toBe true
            expect Token.get()
            .toBe 'notkeeping'
            expect $http.defaults.headers.common[header_key]
            .toBe 'notkeeping'
            expect webStorage.session.get storage_key
            .toBe 'notkeeping'

            Token.set null, true
            expect Token.empty()
            .toBe true
            expect Token.exists()
            .toBe false
            expect Token.get()
            .toBe ''
            expect $http.defaults.headers.common[header_key]
            .toBe undefined
            expect webStorage.local.get storage_key
            .toBe null


        it 'multiple token supplying', ->
            Token.set 'token1', true
            expect Token.get()
            .toBe 'token1'

            Token.set 'token2', false
            expect Token.get()
            .toBe 'token2'

            Token.set 'token3', true
            expect Token.get()
            .toBe 'token3'

            Token.set 'token4', false
            expect Token.get()
            .toBe 'token4'


        it 'clear token', ->
            Token.set 'valid token'
            expect Token.get()
            .toBe 'valid token'

            Token.clear()
            expect Token.empty()
            .toBe true
            expect Token.exists()
            .toBe false
            expect Token.get()
            .toBe ''
            expect $http.defaults.headers.common[header_key]
            .toBe undefined
            expect webStorage.local.get storage_key
            .toBe null


        it 'set invalid token', ->
            Token.set 'valid token'
            expect Token.get()
            .toBe 'valid token'

            Token.set null
            expect Token.empty()
            .toBe true
            expect Token.exists()
            .toBe false
            expect Token.get()
            .toBe ''
            expect $http.defaults.headers.common[header_key]
            .toBe undefined
            expect webStorage.local.get storage_key
            .toBe null


    describe 'store token', ->
        test_token_in_session = 'TEST_TOKEN_IN_SESSION'
        test_token_in_local = 'TEST_TOKEN_IN_LOCAL'

        beforeEach ->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''


        it 'store from session', inject ($http, webStorage)->
            webStorage.session.add storage_key, test_token_in_session

            inject (Token)->
                expect Token.get()
                .toBe test_token_in_session
                expect $http.defaults.headers.common[header_key]
                .toBe test_token_in_session


        it 'store from local', inject ($http, webStorage)->
            webStorage.local.add storage_key, test_token_in_local

            inject (Token)->
                expect Token.get()
                .toBe test_token_in_local
                expect $http.defaults.headers.common[header_key]
                .toBe test_token_in_local


        it 'store from session(local/session both have token)', inject ($http, webStorage)->
            webStorage.session.add storage_key, test_token_in_session
            webStorage.local.add storage_key, test_token_in_local

            inject (Token)->
                expect Token.get()
                .toBe test_token_in_session
                expect $http.defaults.headers.common[header_key]
                .toBe test_token_in_session


describe 'Token(local is not supported)', ->
    _localStorageSetItem = null
    TokenProvider = null

    storage_key = 'token'
    header_key = 'HEADER_KEY'
    test_token = 'TEST_TOKEN'

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        _localStorageSetItem = window.localStorage.setItem
        window.localStorage.setItem = undefined

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

        inject (webStorage)->
            webStorage.memory.clear()
            webStorage.session.clear()
            webStorage.local.clear()

    afterEach ->
        window.localStorage.setItem = _localStorageSetItem

        localStorage.clear()
        sessionStorage.clear()


    describe 'configured', ->
        Token = $http = webStorage = null
        beforeEach ->
            TokenProvider.setStorageKey storage_key
            TokenProvider.setHeaderKey header_key
            TokenProvider.setTokenPrefix ''
            inject (_Token_, _$http_, _webStorage_)->
                Token = _Token_
                $http = _$http_
                webStorage = _webStorage_


        it 'confirm supported', ->
            expect webStorage.local.isSupported
            .toBe false
            expect webStorage.session.isSupported
            .toBe true


        it 'set token keeping', ->
            Token.set test_token, true

            expect $http.defaults.headers.common[header_key]
            .toBe test_token
            expect webStorage.session.get storage_key
            .toBe test_token


        it 'set token not keeping', ->
            Token.set test_token, false

            expect $http.defaults.headers.common[header_key]
            .toBe test_token
            expect webStorage.session.get storage_key
            .toBe test_token


    describe 'store token', ->
        test_token_in_session = 'TEST_TOKEN_IN_SESSION'

        beforeEach ->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''


        it 'not store', inject ($http, webStorage)->
            inject (Token)->
                expect Token.get()
                .toBe ''
                expect $http.defaults.headers.common[header_key]
                .toBe undefined


        it 'store from session', inject ($http, webStorage)->
            webStorage.session.add storage_key, test_token_in_session

            inject (Token)->
                expect Token.get()
                .toBe test_token_in_session
                expect $http.defaults.headers.common[header_key]
                .toBe test_token_in_session



describe 'Token(session is not supported)', ->
    _sessionStorageSetItem = null
    TokenProvider = null

    storage_key = 'token'
    header_key = 'HEADER_KEY'
    test_token = 'TEST_TOKEN'

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        _sessionStorageSetItem = window.sessionStorage.setItem
        window.sessionStorage.setItem = undefined

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

        inject (webStorage)->
            webStorage.memory.clear()
            webStorage.session.clear()
            webStorage.local.clear()

    afterEach ->
        window.sessionStorage.setItem = _sessionStorageSetItem

        localStorage.clear()
        sessionStorage.clear()


    describe 'configured', ->
        Token = $http = webStorage = null
        beforeEach ->
            TokenProvider.setStorageKey storage_key
            TokenProvider.setHeaderKey header_key
            TokenProvider.setTokenPrefix ''
            inject (_Token_, _$http_, _webStorage_)->
                Token = _Token_
                $http = _$http_
                webStorage = _webStorage_

        it 'confirm supported', ->
            expect webStorage.local.isSupported
            .toBe true
            expect webStorage.session.isSupported
            .toBe false


        it 'set token keeping', ->
            Token.set test_token, true

            expect $http.defaults.headers.common[header_key]
            .toBe test_token
            expect webStorage.local.get storage_key
            .toBe test_token


        it 'set token not keeping', ->
            Token.set test_token, false

            expect $http.defaults.headers.common[header_key]
            .toBe test_token
            expect webStorage.memory.get storage_key
            .toBe test_token


    describe 'store token', ->
        test_token_in_local = 'TEST_TOKEN_IN_LOCAL'

        beforeEach ->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''


        it 'not store', inject ($http, webStorage)->
            inject (Token)->
                expect Token.get()
                .toBe ''
                expect $http.defaults.headers.common[header_key]
                .toBe undefined


        it 'store from local', inject ($http, webStorage)->
            webStorage.local.add storage_key, test_token_in_local

            inject (Token)->
                expect Token.get()
                .toBe test_token_in_local
                expect $http.defaults.headers.common[header_key]
                .toBe test_token_in_local


describe 'Token(session/local are both not supported)', ->
    _sessionStorageSetItem = null
    _localStorageSetItem = null
    TokenProvider = null

    storage_key = 'token'
    header_key = 'HEADER_KEY'
    test_token = 'TEST_TOKEN'

    beforeEach ->
        localStorage.clear()
        sessionStorage.clear()

        _sessionStorageSetItem = window.sessionStorage.setItem
        window.sessionStorage.setItem = undefined
        _localStorageSetItem = window.localStorage.setItem
        window.localStorage.setItem = undefined

        angular.module 'TokenTestModule', [moduleCore]
        .config (_TokenProvider_)->
            TokenProvider = _TokenProvider_

        module 'TokenTestModule'

        inject (webStorage)->
            webStorage.memory.clear()
            webStorage.session.clear()
            webStorage.local.clear()

    afterEach ->
        window.sessionStorage.setItem = _sessionStorageSetItem
        window.localStorage.setItem = _localStorageSetItem

        localStorage.clear()
        sessionStorage.clear()


    describe 'configured', ->
        Token = $http = webStorage = null
        beforeEach ->
            TokenProvider.setStorageKey storage_key
            TokenProvider.setHeaderKey header_key
            TokenProvider.setTokenPrefix ''
            inject (_Token_, _$http_, _webStorage_)->
                Token = _Token_
                $http = _$http_
                webStorage = _webStorage_


        it 'confirm supported', ->
            expect webStorage.local.isSupported
            .toBe false
            expect webStorage.session.isSupported
            .toBe false


        it 'set token keeping', ->
            Token.set test_token, true

            expect $http.defaults.headers.common[header_key]
            .toBe test_token
            expect webStorage.memory.get storage_key
            .toBe test_token


        it 'set token not keeping', ->
            Token.set test_token, false

            expect $http.defaults.headers.common[header_key]
            .toBe test_token
            expect webStorage.memory.get storage_key
            .toBe test_token


    describe 'store token', ->
        beforeEach ->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''


        it 'not store', inject ($http, webStorage)->
            inject (Token)->
                expect Token.get()
                .toBe ''
                expect $http.defaults.headers.common[header_key]
                .toBe undefined

