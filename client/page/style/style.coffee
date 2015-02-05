'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'style',
        url: '/style'
        templateUrl: '/page/style/style.html'
        controller: 'StyleCtrl'
        data:
            title: '北医ネット - スタイル確認ページ'

.controller 'StyleCtrl',
    ($scope, $animate, Notify) ->
        $scope.notify = (type)->
            Notify 'アラート', type: type

        $scope.tooltipClass = ''
        $scope.tooltipColor = (cls)->
            $scope.tooltipClass = cls


        $scope.bariconClass = ['baricon--bars', '']

        $scope.bariconTransform = (cls)->
            $scope.bariconClass[0] = cls
            console.log 'trans'

        $scope.bariconColor = (cls)->
            if cls
                $scope.bariconClass[1] = cls
            else
                $scope.bariconClass[1] = ''
