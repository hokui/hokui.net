'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'style',
        url: '/style'
        templateUrl: '/page/style/style.html'
        controller: 'StyleCtrl'

.controller 'StyleCtrl',
    ($scope, $animate, Notify) ->
        $scope.notify = (type)->
            Notify 'アラート', type: type

        $scope.tooltipStyle = 0
        $scope.tooltipClass = ->
            'tooltip--primary': $scope.tooltipStyle is 1
            'tooltip--secondary': $scope.tooltipStyle is 2
            'tooltip--accent': $scope.tooltipStyle is 3


        $scope.barIconType = 'bars'

        $scope.barIconToTimes = ->
            $scope.barIconType = 'times'
        $scope.barIconToCircle = ->
            $scope.barIconType = 'circle'
        $scope.barIconToBars = ->
            $scope.barIconType = 'bars'

        $scope.barClass = ->
            t =
                bars: 'baricon--bars'
                circle: 'baricon--circle'
                times: 'baricon--times'
            t[$scope.barIconType]

