'use strict'

angular.module modulePage

.config ($stateProvider) ->
    $stateProvider

    .state 'study.subject.personal',
        url: '/personal'
        views:
            'main@study.subject':
                templateUrl: '/page/study/subject/personal/personal.html'
                controller: 'StudyPersonalCtrl'

            'main@study.subject.personal':
                templateUrl: '/page/study/subject/personal/main.html'
                controller: 'StudyPersonalMainCtrl'
        resolve:
            documents: (Document, ResourceStore, subject)->
                Document.query
                    subject_id: subject.id
                    code: '5000-5999'
                .$promise.then (data)->
                    new ResourceStore data

    .state 'study.subject.personal.new',
        url: '/new'
        views:
            'main@study.subject.personal':
                templateUrl: '/page/study/subject/personal/new.html'
                controller: 'StudyPersonalNewCtrl'


.controller 'StudyPersonalCtrl',
    ($scope)->
        1


.controller 'StudyPersonalMainCtrl',
    ($scope, documents, ResourceFieldSorter)->
        $scope.documents = documents
        documents.setSorter new ResourceFieldSorter ['-class_year', 'code']
        $scope.transformed = documents.transformed()
        $scope.cyMap = $scope.generateClassYearMap $scope.transformed


.controller 'StudyPersonalNewCtrl',
    ($scope)->
        1
