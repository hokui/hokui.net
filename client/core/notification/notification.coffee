'use strict'

angular.module moduleCore

.factory 'Notification',
    ($timeout, $q) ->
        _types = ['ok', 'warn', 'danger']

        _default =
            type: _types[0]
            period: 4000
            delay: 0
            autoHide: true

        _visible = false
        _message = ''
        _current = {}
        _timeout_promise = null

        _cancel_closing = ->
            if _timeout_promise?
                $timeout.cancel _timeout_promise
                timeout_promise = null

        current: ->
            _current

        isVisible: ->
            _visible

        getMessage: ->
            _message

        show: (message, options)->
            _cancel_closing()

            if _.isObject options
                _current = _.assign _default, options

            _message = message

            _inner_show = =>
                _visible = true
                if _current.period > 0
                    _timeout_promise = $timeout ()=>
                        @hide()
                    , _current.period

            if _current.delay > 0
                $timeout _inner_show, _current.delay
            else
                _inner_show()

            this

        hide: ->
            _cancel_closing()
            _visible = false
            this

.factory 'Notify',
    (Notification) ->
        (message, options)->
            Notification.show message, options

.run ($rootScope, Notification)->
    $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
        if Notification.current().autoHide
            Notification.hide()
