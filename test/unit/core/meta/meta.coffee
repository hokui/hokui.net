'use strict'

describe 'Meta', ->
    MetaProvider = null

    beforeEach ->
        window.document.title = 'default title'


        angular.module 'MetaTestModule', [moduleCore]
        .config ($stateProvider) ->
            $stateProvider
            .state 'title',
                url: '/title'
                data:
                    title: 'タイトル'

            .state 'description',
                url: '/description'
                data:
                    description: '説明文'

            .state 'keywords',
                url: '/keywords'
                data:
                    keywords: ['キーワード1', 'キーワード2']

            .state 'no_meta',
                url: '/no_meta'

        .config (_MetaProvider_) ->
            MetaProvider = _MetaProvider_

        module 'MetaTestModule'

        inject ->


    it 'default', ->
        expect MetaProvider.defaultTitle()
        .toBe 'default title'
        expect MetaProvider.defaultDescription()
        .toBe ''
        expect MetaProvider.defaultKeywords()
        .toEqual []


    it 'changed', ->
        MetaProvider.defaultTitle 'TITLE'
        MetaProvider.defaultDescription 'DESCRIPTION'
        MetaProvider.defaultKeywords ['WORD1', 'WORD2']

        expect MetaProvider.defaultTitle()
        .toBe 'TITLE'
        expect MetaProvider.defaultDescription()
        .toBe 'DESCRIPTION'
        expect MetaProvider.defaultKeywords()
        .toEqual ['WORD1', 'WORD2']


    describe 'configured(default provided)', ->
        template =
            '<div>'+
            '<title bind-title></title>'+
            '<!-- directive: meta -->'+
            '</div>'

        beforeEach ->
            MetaProvider.defaultTitle 'TITLE'
            MetaProvider.defaultDescription 'DESCRIPTION'
            MetaProvider.defaultKeywords ['WORD1', 'WORD2']


        it 'basic', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            expect Meta.title()
            .toBe 'TITLE'
            expect Meta.description()
            .toBe 'DESCRIPTION'
            expect Meta.keywords()
            .toEqual ['WORD1', 'WORD2']

            expect element.html()
            .toContain 'TITLE'
            expect element.html()
            .toContain '"DESCRIPTION"'
            expect element.html()
            .toContain '"WORD1,WORD2"'


        it 'title', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            expect element.html()
            .toContain 'TITLE'
            expect element.html()
            .not.toContain 'タイトル'

            $state.go 'title'
            $rootScope.$digest()

            expect Meta.title()
            .toBe 'タイトル'

            expect element.html()
            .not.toContain 'TITLE'
            expect element.html()
            .toContain 'タイトル'

            $state.go 'no_meta'
            $rootScope.$digest()

            expect element.html()
            .toContain 'TITLE'
            expect element.html()
            .not.toContain 'タイトル'


        it 'description', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            expect element.html()
            .toContain '"DESCRIPTION"'
            expect element.html()
            .not.toContain '"説明文"'

            $state.go 'description'
            $rootScope.$digest()

            expect Meta.description()
            .toBe '説明文'

            expect element.html()
            .not.toContain '"DESCRIPTION"'
            expect element.html()
            .toContain '"説明文"'

            $state.go 'no_meta'
            $rootScope.$digest()

            expect element.html()
            .toContain '"DESCRIPTION"'
            expect element.html()
            .not.toContain '"説明文"'


        it 'keywords', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            expect element.html()
            .toContain '"WORD1,WORD2"'
            expect element.html()
            .not.toContain '"キーワード1,キーワード2"'

            $state.go 'keywords'
            $rootScope.$digest()

            expect Meta.keywords()
            .toEqual ['キーワード1', 'キーワード2']

            expect element.html()
            .not.toContain '"WORD1,WORD2"'
            expect element.html()
            .toContain '"キーワード1,キーワード2"'

            $state.go 'no_meta'
            $rootScope.$digest()

            expect element.html()
            .toContain '"WORD1,WORD2"'
            expect element.html()
            .not.toContain '"キーワード1,キーワード2"'



    describe 'configured(not default provided)', ->
        template =
            '<div>'+
            '<title bind-title></title>'+
            '<!-- directive: meta -->'+
            '</div>'

        it 'default', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            expect Meta.title()
            .toBe 'default title'
            expect Meta.description()
            .toBe ''
            expect Meta.keywords()
            .toEqual []

            expect element.html()
            .not.toContain '<meta'
            expect element.html()
            .not.toContain 'description'
            expect element.html()
            .not.toContain 'keywords'


        it 'title', inject ($rootScope, $compile, $state, Meta)->
            # not test


        it 'description', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            $state.go 'description'
            $rootScope.$digest()

            expect element.html()
            .toContain '<meta'
            expect element.html()
            .toContain 'description'
            expect element.html()
            .toContain '"説明文"'

            $state.go 'no_meta'
            $rootScope.$digest()

            expect element.html()
            .not.toContain 'description'
            expect element.html()
            .not.toContain '"説明文"'


        it 'keywords', inject ($rootScope, $compile, $state, Meta)->
            element = $compile(template) $rootScope
            $rootScope.$digest()

            $state.go 'keywords'
            $rootScope.$digest()

            expect element.html()
            .toContain '<meta'
            expect element.html()
            .toContain 'keywords'
            expect element.html()
            .toContain '"キーワード1,キーワード2"'

            $state.go 'no_meta'
            $rootScope.$digest()

            expect element.html()
            .not.toContain 'keywords'
            expect element.html()
            .not.toContain '"キーワード1,キーワード2"'
