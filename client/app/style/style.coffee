'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'style',
        url: '/style'
        templateUrl: '/app/style/style.html'
        controller: 'StyleCtrl'

.controller 'StyleCtrl',
    ($scope, $animate, Notify) ->
        $scope.alert = (t)->
            Notify "Alert Type: #{t}", type: t

        $scope.barIconType = 'bars'

        $scope.barIconToTimes = ->
            $scope.barIconType = 'times'
        $scope.barIconToCircle = ->
            $scope.barIconType = 'circle'
        $scope.barIconToBars = ->
            $scope.barIconType = 'bars'

        $scope.barClass = ->
            t =
                bars: 'bar-icon-bars'
                circle: 'bar-icon-circle'
                times: 'bar-icon-times'
            t[$scope.barIconType]
