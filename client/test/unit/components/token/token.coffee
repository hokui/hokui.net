'use strict'

describe 'token provider configuration', ->

    _TokeProvider = null

    beforeEach ->
        angular.module 'TokenProviderTestModule', (->)
        .config (TokenProvider)->
            _TokeProvider = TokenProvider

        module serviceName, 'TokenProviderTestModule'

        inject ->

    it 'tokenKey', ->
        _TokeProvider.tokenKey('tk')
        expect(_TokeProvider.tokenKey()).toBe('tk')

    it 'tokenKey exception', ->
        try
            _TokeProvider.tokenKey ''
            expect(false).toBeTruthy()
        catch e
            expect(true).toBeTruthy()


    it 'storageKey', ->
        _TokeProvider.storageKey('sk')
        expect(_TokeProvider.storageKey()).toBe('sk')

    it 'storageKey exception', ->
        try
            _TokeProvider.storageKey ''
            expect(false).toBeTruthy()
        catch e
            expect(true).toBeTruthy()


    it 'prefix', ->
        _TokeProvider.tokenPrefix 'prefix'
        expect(_TokeProvider.tokenPrefix()).toBe 'prefix'

        _TokeProvider.tokenPrefix ''
        expect(_TokeProvider.tokenPrefix()).toBe ''


describe 'token service with prefix', ->

    token_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'
    token_prefix = 'TEST_TOKEN_PREFIX'

    test_token = 'TEST_TOKEN'

    beforeEach ->
        angular.module 'TokenServiceTestModule', (->)
        .config (TokenProvider)->
            TokenProvider.tokenKey token_key
            TokenProvider.storageKey storage_key
            TokenProvider.tokenPrefix token_prefix

        module serviceName, 'TokenServiceTestModule'


    it 'configuration', inject (Token, storage, $http)->
        expect(Token.tokenKey()).toBe token_key
        expect(Token.storageKey()).toBe storage_key
        expect(Token.tokenPrefix()).toBe token_prefix


    it 'basic', inject (Token, storage, $http)->

        # SET TOKEN
        Token.set test_token

        expect(Token.get()).toBe test_token
        expect(storage.get(storage_key)).toBe test_token

        expect($http.defaults.headers.common[token_key]).toBe token_prefix + ' ' + test_token

        # CLEAR TOKEN
        Token.clear()

        expect(Token.get()).toBe ''
        expect(Token.tokenHeader()).toBe ''
        expect(storage.get(storage_key)?).toBe false

        expect($http.defaults.headers.common[token_key]?).toBe false


    it 'not use storage', inject (Token, storage, $http)->

        # SET TOKEN NOT SAVING TO STORAGE
        Token.set test_token, false

        expect(storage.get(storage_key)?).toBe false

        expect($http.defaults.headers.common[token_key]).toBe token_prefix + ' ' + test_token


describe 'token service without prefix', ->

    token_key = 'TEST_TOKEN_KEY'
    storage_key = 'STORAGE_KEY'

    test_token = 'TEST_TOKEN'


    beforeEach ->
        angular.module 'fakeModule', (->)
        .config (TokenProvider)->
            TokenProvider.tokenKey token_key
            TokenProvider.storageKey storage_key
            TokenProvider.tokenPrefix ''

        module serviceName, 'fakeModule'


    it 'Configuration', inject (Token, storage, $http)->
        expect(Token.tokenPrefix()).toBe ''

        Token.set test_token

        expect(Token.tokenHeader()).toBe test_token

        expect($http.defaults.headers.common[token_key]).toBe test_token


