'use strict'

angular.module modulePage

.controller 'ExamCodeEditorCtrl',
    ($scope, definition)->
        $scope.inning = 98
        $scope.answer = 0
        $scope.onjou = 0

        parse = ->
            $scope.newDoc.code = $scope.answer * 1000 + $scope.onjou * 100 + $scope.inning

        parse()

        $scope.$watch 'answer', parse
        $scope.$watch 'inning', parse
        $scope.$watch 'onjou', parse


        $scope.inningList = [
            label: '中間'
            value: 98
        ,
            label: '期末'
            value: 99
        ]
        for i in _.range 1, 10
            $scope.inningList.push
                label: "第#{i}回"
                value: i

        $scope.onjouList = [
            label: '本試験'
            value: 0
        ]
        for i in _.range 1, 10
            label = '追'
            if i > 1
                label = label + Array(i).join '々'
            label = label + '試験'

            $scope.onjouList.push
                label: label
                value: i


.controller 'QuizCodeEditorCtrl',
    ($scope, definition)->
        $scope.inning = 1
        $scope.answer = 0

        parse = ->
            $scope.newDoc.code = 2000 + $scope.answer * 1000 + $scope.inning

        parse()

        $scope.$watch 'answer', parse
        $scope.$watch 'inning', parse

        $scope.inningList = []
        for i in _.range 1, 100
            $scope.inningList.push
                label: "第#{i}回"
                value: i



.controller 'SummaryCodeEditorCtrl',
    ($scope, definition)->
        $scope.inning = 1

        parse = ->
            $scope.newDoc.code = 4000 + $scope.inning

        parse()

        $scope.$watch 'answer', parse
        $scope.$watch 'inning', parse

        $scope.inningList = []
        for i in _.range 1, 100
            $scope.inningList.push
                label: "第#{i}回"
                value: i


.controller 'PersonalCodeEditorCtrl',
    ($scope, definition)->
        $scope.newDoc.code = 5000
