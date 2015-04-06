'use strict'

angular.module modulePage

.config ($stateProvider) ->
    $stateProvider

    .state 'study.subject.quiz',
        url: '/quiz'
        views:
            'main@study.subject':
                templateUrl: '/page/study/subject/quiz/quiz.html'
                controller: 'StudyQuizCtrl'

            'main@study.subject.quiz':
                templateUrl: '/page/study/subject/quiz/main.html'
                controller: 'StudyQuizMainCtrl'
        resolve:
            documents: (Document, ResourceStore, subject)->
                Document.query
                    subject_id: subject.id
                    code: '2000-3999'
                .$promise.then (data)->
                    new ResourceStore data

    .state 'study.subject.quiz.new',
        url: '/new'
        views:
            'main@study.subject.quiz':
                templateUrl: '/page/study/subject/quiz/new.html'
                controller: 'StudyQuizNewCtrl'

.controller 'StudyQuizCtrl',
    ($scope)->
        1

.controller 'StudyQuizMainCtrl',
    ($scope, $stateParams, ResourceStore, NotFound, documents, ResourceFieldSorter, DownloadDocumentFile)->
        documents.setSorter new ResourceFieldSorter ['class_year', 'code']
        $scope.documents = documents

        $scope.parseCode = (code)->
            time = code % 100
            ret = if time > 0 then "第#{time}回" else ''
            if code > 3000
                ret = ret + '(解答)'
            ret

        $scope.downloadFile = (file)->
            DownloadDocumentFile file


.controller 'StudyQuizNewCtrl',
    ($scope)->
        1
