'use strict'

describe 'TokenProvider', ->

    _TokenProvider = null

    beforeEach ->
        angular.module 'TokenProviderTestModule', [moduleCore]
        .config (TokenProvider)->
            _TokenProvider = TokenProvider

        module 'TokenProviderTestModule'

    it 'header_key', inject ->
        _TokenProvider.setHeaderKey 'tk'
        expect(_TokenProvider.getHeaderKey()).toBe 'tk'

        try
            _TokenProvider.setHeaderKey ''
            expect(false).toBeTruthy()
        catch e
            expect(true).toBeTruthy()


    it 'storage_key', inject ->
        _TokenProvider.setStorageKey 'sk'
        expect(_TokenProvider.getStorageKey()).toBe 'sk'

        try
            _TokenProvider.storageKey ''
            expect(false).toBeTruthy()
        catch e
            expect(true).toBeTruthy()


    it 'prefix', inject ->
        _TokenProvider.setTokenPrefix 'prefix'
        expect(_TokenProvider.getTokenPrefix()).toBe 'prefix'

        _TokenProvider.setTokenPrefix ''
        expect(_TokenProvider.getTokenPrefix()).toBe ''


describe 'TokenService(With Prefix)', ->
    header_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'
    token_prefix = 'TEST_TOKEN_PREFIX'
    test_token = 'TEST_TOKEN'

    beforeEach ->
        angular.module 'TokenServiceTestModule', [moduleCore]
        .config (TokenProvider)->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix token_prefix

        module 'TokenServiceTestModule'

        inject (Token)->
            Token.clear()

    it 'basic', inject (Token, $http)->
        Token.set test_token

        expect(Token.get()).toBe test_token
        expect($http.defaults.headers.common[header_key]).toBe "#{token_prefix} #{test_token}"

    it 'clear', inject (Token, $http)->
        expect(Token.get()).toBe ''
        expect($http.defaults.headers.common[header_key]?).toBe false


describe 'TokenService(Without Prefix)', ->
    header_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'
    test_token = 'TEST_TOKEN'

    beforeEach ->
        angular.module 'TokenServiceTestModule', [moduleCore]
        .config (TokenProvider)->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''

        module 'TokenServiceTestModule'

        inject (Token)->
            Token.clear()

    it 'basic', inject (Token, $http)->
        Token.set test_token
        expect($http.defaults.headers.common[header_key]).toBe test_token


describe 'TokenService(Store Token)', ->
    header_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'
    test_token_session = 'TEST_TOKEN_SESSION'
    test_token_local = 'TEST_TOKEN_LOCAL'

    beforeEach ->
        angular.module 'TokenServiceTestModule', [moduleCore]
        .config (TokenProvider)->
            TokenProvider.setHeaderKey header_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''

        module 'TokenServiceTestModule'

        inject (webStorage)->
            webStorage.session.clear()
            webStorage.memory.clear()
            webStorage.local.clear()

    describe 'Token is in sessionStorage', ->
        beforeEach ->
            inject (webStorage)->
                webStorage.session.add storage_key, test_token_session

        it 'store from session', inject (Token, $http)->
            expect(Token.get()).toBe test_token_session
            expect($http.defaults.headers.common[header_key]).toBe test_token_session

    describe 'Token is in localStorage', ->
        beforeEach ->
            inject (webStorage)->
                webStorage.local.add storage_key, test_token_local

        it 'store from local', inject (Token, $http)->
            expect(Token.get()).toBe test_token_local
            expect($http.defaults.headers.common[header_key]).toBe test_token_local



    describe 'Token is in both sessionStorage and localStorage', ->
        beforeEach ->
            inject (webStorage)->
                webStorage.session.add storage_key, test_token_session
                webStorage.local.add storage_key, test_token_local

        it 'store from session', inject (Token, $http)->
            expect(Token.get()).toBe test_token_session
            expect($http.defaults.headers.common[header_key]).toBe test_token_session


