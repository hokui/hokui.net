'use strict'

angular.module modulePage

.config ($stateProvider) ->

    documentDifinitionList = [
        name: 'exam'
        label: '過去問'
        codeRange: '0-1999'
        inningLabel: (code)->
            base = switch code % 100
                when 99 then '期末'
                when 98 then '中間'
                else "第#{code % 100}回"

            i_onjou = (code % 1000) // 100
            if i_onjou > 0
                onjou = '追'
                if i_onjou > 1
                    onjou = onjou + Array(i_onjou).join('々')
                onjou = onjou + '試'
            else
                onjou = ''
            if i_onjou > 0 then"#{base}#{onjou}" else base

        codeLabel: (code)->
            name = if code > 1000 then '解答' else '問題'

            inning = @inningLabel code

            "#{inning}の#{name}"

        isAnswer: (code, doc)->
            code > 1000

        codeEditorTemplate: 'exam.code_editor.html'
        codeEditorController: 'ExamCodeEditorCtrl'
    ,
        name: 'quiz'
        label: '小テスト'
        codeRange: '2000-3999'
        inningLabel: (code)->
            time = code % 100
            if time > 0 then "第#{time}回" else ''

        isAnswer: (code)->
            code > 3000

        codeEditorTemplate: 'quiz.code_editor.html'
        codeEditorController: 'QuizCodeEditorCtrl'

        codeLabel: (code)->
            name = if code > 3000 then '解答' else '問題'

            inning = @inningLabel code

            "#{inning}の#{@label}の#{name}"

    ,
        name: 'summary'
        label: '講義資料'
        codeRange: '4000-4999'
        inningLabel: (code)->
            time = code % 100
            if time > 0 then "第#{time}回" else ''
        codeEditorTemplate: 'summary.code_editor.html'
        codeEditorController: 'SummaryCodeEditorCtrl'
        codeLabel: (code)->
            inning = @inningLabel code
            "#{inning}の#{@label}"

    ,
        name: 'personal'
        label: '個人作成資料'
        codeRange: '5000-5999'
        inningLabel: null
        codeEditorTemplate: 'personal.code_editor.html'
        codeEditorController: 'PersonalCodeEditorCtrl'
        codeLabel: (code)->
            @label
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

                documentFiles: (documents, ResourceStore)->
                    files = _.reduce documents.original, (result, doc)->
                        _.forEach doc.document_files, (docFile)->
                            result.push docFile
                        result
                    , []
                    new ResourceStore files

                definition: ->
                    obj

        .state "study.subject.#{obj.name}.new",
            url: '/new'
            views:
                "main@study.subject.#{obj.name}":
                    templateUrl: '/page/study/subject/document/new.html'
                    controller: 'StudyDocumentNewCtrl'
                "codeEditor@study.subject.#{obj.name}.new":
                    templateUrl: "/page/study/subject/document/code_editor/#{obj.name}.html"
                    controller: obj.codeEditorController

        .state "study.subject.#{obj.name}.detail",
            url: '/{documentFileId:int}'
            abstract: true

        .state "study.subject.#{obj.name}.detail.edit",
            url: '/edit'
            views:
                "main@study.subject.#{obj.name}":
                    templateUrl: '/page/study/subject/document/edit.html'
                    controller: 'StudyDocumentEditCtrl'
            resolve:
                documentFile: (documentFiles, $stateParams)->
                    documentFiles.retrieve $stateParams.documentFileId


.factory 'GenerateClassYearMap', ->
    (docs)->
        map = []
        lastIndex = 0
        _.forEach docs, (a, i)->
            b = docs[i-1]
            if b? and a.class_year is b.class_year
                map.push 0
                map[lastIndex] = map[lastIndex] + 1
            else
                map.push 1
                lastIndex = i
        map


.factory 'GenerateCodeMap', ->
    (docs)->
        map = []
        lastIndex = 0
        _.forEach docs, (a, i)->
            b = docs[i-1]

            if b? and a.class_year is b.class_year and (a.code % 1000) is (b.code % 1000)
                map.push 0
                map[lastIndex] = map[lastIndex] + 1
            else
                map.push 1
                lastIndex = i
        map


.controller 'StudyDocumentCtrl',
    ($scope)->


.controller 'StudyDocumentMainCtrl',
    ($scope, $state, $window, documents, documentFiles, ResourceFieldSorter, GenerateClassYearMap, GenerateCodeMap, definition, ResourceFilter, IsSmartPhone)->
        $scope.documents = documents
        $scope.documentFiles = documentFiles
        $scope.isSmartPhone = IsSmartPhone

        documents.setSorter new ResourceFieldSorter [
            '-class_year'
        ,
            (A, B)->
                A.code % 1000 - B.code % 1000
        ]
        documents.setFilter new ResourceFilter
            filter: (doc)->
                doc.document_files.length > 0
        $scope.transformed = documents.transformed()

        $scope.inningLabel = definition.inningLabel
        $scope.isAnswer = definition.isAnswer

        $scope.cyMap = GenerateClassYearMap $scope.transformed
        $scope.codeMap = GenerateCodeMap $scope.transformed


        $scope.sameClassYear = (docs, $index)->
            a = docs[$index]
            b = docs.original[$index-1]
            if a? and b?
                return a.class_year is b.class_year
            false

        prevewableExt = [
            'html', 'htm', 'shtml', 'css', 'xml', 'gif', 'jpeg', 'jpg', 'js',
            'atom', 'rss', 'txt', 'png', 'tif', 'tiff', 'ico', 'jng', 'bmp',
            'svg', 'svgz', 'json', 'hqx', 'pdf', 'rtf', 'xls', 'swf', 'mid', 'midi', 'kar',
            'mp3', 'ogg', 'm4a', '3gpp 3gp', 'mp4', 'mpeg', 'mpg', 'mov', 'flv', 'm4v',
            'wmv', 'avi'
        ]

        $scope.previewable = (file)->
            tmp = file.file_name.split '.'
            ext = tmp[tmp.length - 1]
            prevewableExt.indexOf(ext) > -1

        $scope.urlForDocFile = (file)->
            "/contents/document_files/#{file.id}/#{file.file_name}?download_token=#{file.download_token}"


.controller 'StudyDocumentEditCtrl',
    ($scope, $http, Notify, Env, $state, documentFile)->
        if not documentFile?
            $state.go '^.^'

        $scope.documentFile = documentFile
        $scope.deleting = false

        $scope.cancelDeleting = ->
            Notify '削除をキャンセルしました。', type: 'warn'
            $scope.deleting = false

        $scope.performDelete = ->
            if not $scope.deleting
                Notify 'もう一度クリックして削除します。', type: 'warn'
                $scope.deleting = true
            else
                $http.delete "#{Env.apiRoot()}/document_files/#{documentFile.id}"
                .success (data)->
                    $state.go '^.^', {}, reload: true
                    Notify '削除しました'
                .error (err)->
                    Notify 'エラーが発生しました。', type: 'warn'

.controller 'StudyDocumentNewCtrl',
    ($scope, $http, Notify, definition, MaxClassYear, Auth, Env, subject, $state)->
        $scope.maxClassYear = MaxClassYear
        $scope.definition = definition

        $scope.files = []

        $scope.newDoc =
            subject_id: $scope.subject.id
            user_id: Auth.user().id
            comments: ''
            class_year: $scope.userClassYear.year

        $scope.codeEditorTemplate = definition.codeEditorTemplate

        $scope.fileChanged = ($files)->
            e = false
            for file in $files
                dots = file.name.match /\./g
                if (Array.isArray dots) and dots.length > 1
                    e = true
                    if not $scope.errors
                        $scope.errors = []

                    $scope.errors.push
                        'file_md5': 'システムの仕様上、ファイル名にドット「.」を含むファイルはアップロードできません。ファイル名を変更して選択しなおしてください。'

            if not e
                $scope.errors = null

        $scope.uploadButtonLabel = (valid)->
            if valid
                codeLabel = definition.codeLabel $scope.newDoc.code
                "「#{$scope.newDoc.class_year}期の#{subject.title_ja}の#{codeLabel}」をアップロード"
            else
                '入力に不備があります'

        $scope.performUpload = (valid)->
            if valid
                fd = new FormData()
                fd.append 'json', angular.toJson $scope.newDoc
                fd.append 'file', $scope.files[0]

                $http.post "#{Env.apiRoot()}/document_files", fd,
                    transformRequest: angular.identity
                    headers:
                        'Content-Type': undefined
                .success (data)->
                    $state.go '^', {}, reload: true
                    Notify '資料をアップロードしました。'

                .error (err)->
                    $scope.errors = err.errors
                    Notify '入力にエラーがあります。', type: 'warn'

            else
                Notify '入力にエラーがあります。', type: 'warn'
