'use strict'

angular.module modulePage

.config ($stateProvider) ->
    $stateProvider

    .state 'study.subject.exam',
        url: '/exam'
        views:
            'main@study.subject':
                templateUrl: '/page/study/subject/exam/exam.html'
                controller: 'StudyExamCtrl'

            'main@study.subject.exam':
                templateUrl: '/page/study/subject/exam/main.html'
                controller: 'StudyExamMainCtrl'
        resolve:
            documents: (Document, ResourceStore, subject)->
                Document.query
                    subject_id: subject.id
                    code: '0-1999'
                .$promise.then (data)->
                    new ResourceStore data

    .state 'study.subject.exam.new',
        url: '/new'
        views:
            'main@study.subject.exam':
                templateUrl: '/page/study/subject/exam/new.html'
                controller: 'StudyExamNewCtrl'


.controller 'StudyExamCtrl',
    ($scope)->
        1


.controller 'StudyExamMainCtrl',
    ($scope, documents, ResourceFieldSorter)->
        $scope.documents = documents
        documents.setSorter new ResourceFieldSorter ['-class_year', 'code']
        $scope.transformed = documents.transformed()
        $scope.cyMap = $scope.generateClassYearMap $scope.transformed

        $scope.parseCode = (code)->
            result = ''
            time = code % 100
            if time is 98
                result = result + '中間'
            else if time is 99
                result = result + '期末'
            else if time is 0
                return ''
            else
                result = '第' + result + time + '回'
            result

            onjou = (code % 1000) // 100
            if onjou > 0
                result = result + '追'
                if onjou > 1
                    result = result + Array(onjou).join('々')
                result = result + '試'

            if code > 1000 then result + '(解答)' else result


.controller 'StudyExamNewCtrl',
    ($scope)->
        1
