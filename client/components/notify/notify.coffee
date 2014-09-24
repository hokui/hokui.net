'use strict'

angular.module appName
.controller 'NotifyCtrl',
    ($scope, Notification) ->
        $scope.Notification = Notification

        $scope.alertType = ->
            'alert-info': Notification.current().type is 'info'
            'alert-success': Notification.current().type is 'success'
            'alert-warning': Notification.current().type is 'warning'
            'alert-danger': Notification.current().type is 'danger'


.factory 'Notification',
    ($timeout) ->
        types = ['info', 'success', 'warning', 'danger']
        defaults =
            type: types[0]
            period: 5000

        current =
            type: defaults.type
            period: defaults.period
            message: ''
            visible: false

        timeout_promise = null

        cancel_closeing = ->
            if timeout_promise?
                $timeout.cancel timeout_promise
                timeout_promise = null

        current: ->
            current

        isVisible: ->
            current.visible

        show: (message, options)->
            cancel_closeing()

            if options?.type? and (types.indexOf(options.type) > -1)
                current.type = options.type
            else
                current.type = defaults.type

            if options?.period?
                if options.period > 0
                    current.period = options.period
                else
                    current.period = -1
            else
                current.period = defaults.period

            current.message = message


            current.visible = true

            if current.period > 0
                timeout_promise = $timeout @hide, current.period

        hide: ->
            cancel_closeing()
            current.visible = false

.factory 'Notify',
    (Notification) ->
        (message, options)->
            Notification.show(message, options)

