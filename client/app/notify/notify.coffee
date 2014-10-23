'use strict'

angular.module appName

.controller 'NotifyCtrl',
    ($scope, Notification) ->
        $scope.Notification = Notification

.factory 'Notify',
    (Notification) ->
        (message, options)->
            Notification.show(message, options)

