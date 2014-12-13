'use strict'

describe 'TokenProvider', ->

    _TokenProvider = null

    beforeEach ->
        angular.module 'TokenProviderTestModule', (->)
        .config (TokenProvider)->
            _TokenProvider = TokenProvider

        module serviceName, 'TokenProviderTestModule'

        inject ->

    it 'header_key', ->
        _TokenProvider.setHeaderKey 'tk'
        expect(_TokenProvider.getHeaderKey()).toBe 'tk'

        try
            _TokenProvider.setHeaderKey ''
            expect(false).toBeTruthy()
        catch e
            expect(true).toBeTruthy()


    it 'storage_key', ->
        _TokenProvider.setStorageKey 'sk'
        expect(_TokenProvider.getStorageKey()).toBe 'sk'

        try
            _TokenProvider.storageKey ''
            expect(false).toBeTruthy()
        catch e
            expect(true).toBeTruthy()


    it 'prefix', ->
        _TokenProvider.setTokenPrefix 'prefix'
        expect(_TokenProvider.getTokenPrefix()).toBe 'prefix'

        _TokenProvider.setTokenPrefix ''
        expect(_TokenProvider.getTokenPrefix()).toBe ''


describe 'TokenService', ->
    token_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'
    token_prefix = 'TEST_TOKEN_PREFIX'

    test_token = 'TEST_TOKEN'

    beforeEach ->
        angular.module 'TokenServiceTestModule', (->)
        .config (TokenProvider)->
            TokenProvider.setHeaderKey token_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix token_prefix

        module serviceName, 'TokenServiceTestModule'

        inject ($injector)->
            Token = $injector.get 'Token'
            Token.clear()


    it 'config', inject (Token)->
        expect(Token.getHeaderKey()).toBe token_key
        expect(Token.getStorageKey()).toBe storage_key
        expect(Token.getTokenPrefix()).toBe token_prefix


    it 'basic', inject (Token, $http, store)->
        Token.set test_token

        expect(Token.get()).toBe test_token
        expect(store.get(storage_key)).toBe test_token
        expect($http.defaults.headers.common[token_key]).toBe "#{token_prefix} #{test_token}"

    it 'clear', inject (Token, $http)->
        expect(Token.get()).toBe ''
        expect(Token.getTokenHeader()).toBe ''
        expect($http.defaults.headers.common[token_key]?).toBe false


describe 'TokenService(Without Prefix)', ->
    token_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'

    test_token = 'TEST_TOKEN'

    beforeEach ->
        angular.module 'TokenServiceTestModule', (->)
        .config (TokenProvider)->
            TokenProvider.setHeaderKey token_key
            TokenProvider.setStorageKey storage_key
            TokenProvider.setTokenPrefix ''

        module serviceName, 'TokenServiceTestModule'

        inject ($injector)->
            Token = $injector.get 'Token'
            Token.clear()

    it 'basic', inject (Token, $http)->
        Token.set test_token
        expect($http.defaults.headers.common[token_key]).toBe test_token
