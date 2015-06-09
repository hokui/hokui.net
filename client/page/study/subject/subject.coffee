'use strict'

angular.module modulePage

.config ($stateProvider) ->
    $stateProvider

    .state 'study.subject',
        url: '/:subjectName'
        views:
            'main@study':
                templateUrl: '/page/study/subject/subject.html'
                controller: 'StudySubjectCtrl'
            'main@study.subject':
                controller: 'StudySubjectMainCtrl'
        resolve:
            subject: (subjects, $stateParams)->
                subjects.retrieve $stateParams.subjectName, 'title_en'


.factory 'GetDocumentFileToken', ($http, Env, Notify)->
    (documentFile, cb)->
        $http.get "#{Env.apiRoot()}/document_files/#{documentFile.id}/download_token"
        .success (data)->
            cb data.token

.controller 'StudySubjectCtrl',
    ($scope, $state, NotFound, subject, GetDocumentFileToken, $window)->
        if subject
            $scope.subject = subject
        else
            NotFound()

        $scope.items = [
                title: '過去問'
                state: '.exam'
            ,
                title: '小テスト'
                state: '.quiz'
            ,
                title: '講義資料'
                state: '.summary'
            ,
                title: '個人作成資料'
                state: '.personal'
        ]



.controller 'StudySubjectMainCtrl',
    ($scope, $state, $stateParams)->
        $state.go 'study.subject.exam'
