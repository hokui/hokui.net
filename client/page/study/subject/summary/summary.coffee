'use strict'

angular.module modulePage

.config ($stateProvider) ->
    $stateProvider

    .state 'study.subject.summary',
        url: '/summary'
        views:
            'main@study.subject':
                templateUrl: '/page/study/subject/summary/summary.html'
                controller: 'StudySummaeyCtrl'

            'main@study.subject.summary':
                templateUrl: '/page/study/subject/summary/main.html'
                controller: 'StudySummaeyMainCtrl'
        resolve:
            documents: (Document, ResourceStore, subject)->
                Document.query
                    subject_id: subject.id
                    code: '4000-4999'
                .$promise.then (data)->
                    new ResourceStore data

    .state 'study.subject.summary.new',
        url: '/new'
        views:
            'main@study.subject.summary':
                templateUrl: '/page/study/subject/summary/new.html'
                controller: 'StudySummaeyNewCtrl'


.controller 'StudySummaeyCtrl',
    ($scope)->
        1


.controller 'StudySummaeyMainCtrl',
    ($scope, $stateParams, ResourceStore, NotFound, documents, ResourceFieldSorter, DownloadDocumentFile)->
        $scope.documents = documents

        documents.setSorter new ResourceFieldSorter ['class_year', 'code']

        $scope.parseCode = (code)->
            time = code % 100
            if time > 0 then "第#{time}回" else ''

        $scope.downloadFile = (file)->
            DownloadDocumentFile file


.controller 'StudySummaeyNewCtrl',
    ($scope)->
        1
