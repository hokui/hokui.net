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

        $scope.sameClassYear = (docs, $index)->
            a = docs[$index]
            b = docs.original[$index-1]
            if a? and b?
                return a.class_year is b.class_year
            false

        prevewableFiles =
            [
                'application/pdf'
            ]


        $scope.previewable = (file)->
            prevewableFiles.indexOf file.file_content_type > 0

        $scope.downloadFile = (file)->
            GetDocumentFileToken file, (token)->
                url = "/contents/document_files/#{file.id}/download?download_token=#{token}"
                $window.open url

        $scope.previewFile = (file)->
            GetDocumentFileToken file, (token)->
                url = "/contents/document_files/#{file.id}?download_token=#{token}"
                $window.open url


        $scope.generateClassYearMap = (docs)->
            map = new Array docs.length
            lastIndex = 0
            lastClassYear = -1
            _.forEach docs, (doc, i)->
                if docs[i-1]? and docs[i-1].class_year is doc.class_year
                    map[i] = 0
                    map[lastIndex] = map[lastIndex] + 1
                else
                    map[i] = 1
                    lastIndex = i
            map

.controller 'StudySubjectMainCtrl',
    ($scope, $state, $stateParams)->
        $state.go 'study.subject.exam'


