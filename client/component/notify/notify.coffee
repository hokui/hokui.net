'use strict'

angular.module moduleComponent

.controller 'NotifyCtrl',
    ($scope, Notification) ->
        $scope.Notification = Notification

        alertTypeClassMap =
            ok: 'primary'
            warn: 'secondary'
            danger: 'accent'

        $scope.alertClass = ->
            'alert--' + alertTypeClassMap[Notification.current().type]


