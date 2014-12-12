'use strict'

angular.module moduleCore

.factory 'Notification',
    ($timeout, $q) ->
        _types = ['ok', 'warn', 'danger']
        _type_class_map =
            ok: 'primary'
            warn: 'secondary'
            danger: 'accent'

        _default =
            type: _types[0]
            period: 4000
            delay: 0

        _visible = false
        _message = ''

        _current = {}

        _set_default = ->
            _current = angular.copy _default

        _set_default()

        _timeout_promise = null

        _cancel_closing = ->
            if _timeout_promise?
                $timeout.cancel _timeout_promise
                timeout_promise = null

        ###*
        interfece
        ###

        alertClass: ->
            "alert--#{_type_class_map[_current.type]}"

        current: ->
            _current

        isVisible: ->
            _visible

        getMessage: ->
            _message

        show: (message, options)->
            _cancel_closing()
            _set_default()

            if options?
                if options.type? and (_types.indexOf(options.type) > -1)
                    _current.type = options.type

                if options.period?
                    p = parseInt options.period
                    if not isNaN p
                        _current.period = if p > 0 then p else -1

                if options.delay?
                    d = parseInt options.delay
                    if not isNaN p
                        _current.delay = if d > 0 then d else 0

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
            Notification.show(message, options)

.run ($rootScope, Notification)->
    $rootScope.$on '$stateChangeStart', (ev, toState, toParams, fromState, fromParams)->
        Notification.hide()
