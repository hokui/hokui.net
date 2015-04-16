'use strict'

angular.module modulePage

.config ($stateProvider) ->

    documentDifinitionList = [
        name: 'exam'
        codeRange: '0-1999'
        timeLabel: (code)->
            result = ''

            time = code % 100
            if time is 98
                result = result + '中間'
            else if time is 99
                result = result + '期末'
            else if time is 0
                result = ''
            else
                result = '第' + result + time + '回'

            onjou = (code % 1000) // 100
            if onjou > 0
                result = result + '追'
                if onjou > 1
                    result = result + Array(onjou).join('々')
                result = result + '試'

            result

        # isAnswer: (code, doc)->
        #     code > 1000
    ,
        name: 'quiz'
        codeRange: '2000-3999'
        timeLabel: (code)->
            time = code % 100
            if time > 0 then "第#{time}回" else ''

        # isAnswer: (code)->
        #     code > 3000
    ,
        name: 'summary'
        codeRange: '4000-4999'
        timeLabel: (code)->
            time = code % 100
            if time > 0 then "第#{time}回" else ''
    ,
        name: 'personal'
        codeRange: '5000-5999'
        timeLabel: null
    ]

    _.forEach documentDifinitionList, (obj)->
        $stateProvider
        .state "study.subject.#{obj.name}",
            url: "/#{obj.name}"
            views:
                'main@study.subject':
                    templateUrl: '/page/study/subject/document/document.html'
                    controller: 'StudyDocumentCtrl'

                "main@study.subject.#{obj.name}":
                    templateUrl: '/page/study/subject/document/main.html'
                    controller: 'StudyDocumentMainCtrl'
            resolve:
                documents: (Document, ResourceStore, subject)->
                    Document.query
                        subject_id: subject.id
                        code: obj.codeRange
                    .$promise.then (data)->
                        new ResourceStore data
            data:
                definition: obj

        .state "study.subject.#{obj.name}.new",
            url: '/new'
            views:
                "main@study.subject.#{obj.name}":
                    templateUrl: '/page/study/subject/document/new.html'
                    controller: 'StudyDocumentNewCtrl'


.factory 'GenerateClassYearMap', ->
    (docs)->
        map = new Array docs.length
        lastIndex = 0
        _.forEach docs, (doc, i)->
            if docs[i-1]? and docs[i-1].class_year is doc.class_year
                map[i] = 0
                map[lastIndex] = map[lastIndex] + 1
            else
                map[i] = 1
                lastIndex = i
        map


.factory 'GenerateCodeMap', ->
    (docs)->
        map = new Array docs.length
        lastIndex = 0
        _.forEach docs, (doc, i)->
            if docs[i-1]? and (docs[i].code % 1000) is (docs[i-1].code % 1000)
                map[i] = 0
                map[lastIndex] = map[lastIndex] + 1
            else
                map[i] = 1
                lastIndex = i
        map


.controller 'StudyDocumentCtrl',
    ($scope)->


.controller 'StudyDocumentMainCtrl',
    ($scope, $state, $window, documents, ResourceFieldSorter, GenerateClassYearMap, GenerateCodeMap, GetDocumentFileToken, Download)->
        $scope.documents = documents
        documents.setSorter new ResourceFieldSorter [
            '-class_year'
        ,
            (A, B)->
                A.code % 1000 - B.code % 1000
        ]
        $scope.transformed = documents.transformed()

        $scope.timeLabel = $state.current.data.definition.timeLabel
        $scope.isAnswer = $state.current.data.definition.isAnswer

        $scope.cyMap = GenerateClassYearMap $scope.transformed
        $scope.codeMap = GenerateCodeMap $scope.transformed


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
                url = "/contents/document_files/#{file.id}?download_token=#{token}"
                Download url, file.file_name

        $scope.previewFile = (file)->
            GetDocumentFileToken file, (token)->
                url = "/contents/document_files/#{file.id}?download_token=#{token}"
                $window.location.href = url


.controller 'StudyDocumentNewCtrl',
    ($scope)->
        1
