'use strict'

angular.module moduleCore

.provider 'Meta', ->
    _default_title = "#{window.document.title}" or ''
    _default_description = ''
    _default_keywords = []

    defaultTitle: (title)->
        if _.isString title
            _default_title = title
        _default_title

    defaultDescription: (description)->
        if _.isString description
            _default_description = description
        _default_description

    defaultKeywords: (keywords)->
        if _.isArray keywords
            _default_keywords = keywords
        _default_keywords


    $get: ($rootScope, $q)->
        _title = _default_title
        _description = _default_description
        _keywords = _default_keywords

        _notifier = $q.defer()

        Meta =
            title: (title)->
                if _.isString title
                    _title = title
                    _notifier.notify 'title'
                _title

            description: (description)->
                if _.isString description
                    _description = description
                    _notifier.notify 'description'
                _description

            keywords: (keywords)->
                if _.isArray keywords
                    _keywords = keywords
                    _notifier.notify 'keywords'
                _keywords

            onChange: (ev)->
                _notifier.promise.then (->), (->), ev

        $rootScope.$on '$stateChangeSuccess', (ev, toState, toParams, fromState, fromParams)->
            if t = toState.data?.title
                Meta.title t
            else
                Meta.title _default_title

            if t = toState.data?.description
                Meta.description t
            else
                Meta.description _default_description

            if k = toState.data?.keywords
                Meta.keywords k
            else
                Meta.keywords _default_keywords


        Meta

.directive 'meta', ($compile, Meta)->
    restrict: 'M'
    link: (scope, element, attrs)->
        elDescription = null
        elKeywords = null

        updateDescription = ->
            description = Meta.description()
            if description
                if elDescription
                    elDescription.attr 'content', description
                else
                    elDescription = angular.element '<meta name="description" content="'+description+'">'
                    element.after elDescription
            else
                if elDescription
                    elDescription.remove()
                    elDescription = null

        updateKeywords = ->
            keywordsArray = Meta.keywords()
            if (_.isArray keywordsArray) and keywordsArray.length > 0
                keywords = keywordsArray.join ','
                if elKeywords
                    elKeywords.attr 'content', keywords
                else
                    elKeywords = angular.element '<meta name="keywords" content="'+keywords+'">'
                    element.after $compile(elKeywords) scope
            else
                if elKeywords
                    elKeywords.remove()
                    elKeywords = null

        Meta.onChange (name)->
            switch name
                when 'description'
                    updateDescription()
                when 'keywords'
                    updateKeywords()

        updateDescription()
        updateKeywords()


.directive 'bindTitle', ($window, Meta)->
    link: (scope, element, attrs)->

        updateTitle = ->
            $window.document.title = Meta.title()
            element[0].innerText = Meta.title()

        Meta.onChange (name)->
            if name is 'title'
                updateTitle()

        updateTitle()
