'use strict'

describe 'Env', ->
    EnvProvider = null

    seed =
        text: 'this is seed'

    beforeEach ->
        angular.module 'EnvTestModule', [moduleCore]
        .config (_EnvProvider_)->
            EnvProvider = _EnvProvider_

        module 'EnvTestModule'

        inject ->


    it 'default', inject (Env)->
        expect Env.dev()
        .toBe false

        expect Env.apiRoot()
        .toBe '/api'

        expect Env.seed 'seed'
        .toEqual null


    it 'changed', ->
        EnvProvider.setDev true
        EnvProvider.setSeed 'seed', seed
        EnvProvider.setApiRoot '/api/v1'

        inject (Env)->
            expect Env.dev()
            .toBe true

            expect Env.apiRoot()
            .toBe '/api/v1'

            expect Env.seed 'seed'
            .toEqual seed
