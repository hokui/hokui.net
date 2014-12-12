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
