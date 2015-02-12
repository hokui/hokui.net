'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.subject',
        url: '/subject',
        views:
            'main@admin':
                templateUrl: '/page/admin/subject/subject.html'
                controller: 'AdminSubjectCtrl'
                resolve:
                    subjects: (Subject)->
                        Subject.query().$promise

            'main@admin.subject':
                templateUrl: '/page/admin/subject/list.html'
                controller: 'AdminSubjectListCtrl'


    .state 'admin.subject.new',
        url: '/new',
        views:
            'main@admin.subject':
                templateUrl: '/page/admin/subject/edit.html'
                controller: 'AdminSubjectEditCtrl'

    .state 'admin.subject.detail',
        url: '/{id:int}',
        views:
            'main@admin.subject':
                templateUrl: '/page/admin/subject/detail.html'
                controller: 'AdminSubjectDetailCtrl'

    .state 'admin.subject.detail.edit',
        url: '/edit',
        views:
            'edit@admin.subject.detail':
                templateUrl: '/page/admin/subject/edit.html'
                controller: 'AdminSubjectEditCtrl'


.controller 'AdminSubjectCtrl',
    ($scope, ResourceStore, subjects) ->
        $scope.subjects = new ResourceStore subjects


.controller 'AdminSubjectListCtrl',
    ($scope, ResourceFilter, ResourceFieldSorter, ResourceSorter)->
        $scope.idSorter = new ResourceSorter()
        $scope.titleJaSorter = new ResourceFieldSorter ['title_ja']
        $scope.titleEnSorter = new ResourceFieldSorter ['title_en']

        $scope.subjects.setSorter $scope.idSorter

        subjectFilter = new ResourceFilter()

        $scope.titleFilter = new ResourceFilter
            parent: subjectFilter
            value: ''
            filter: (subject)->
                exp = new RegExp @value
                en = subject.title_en.match exp
                ja = subject.title_ja.match exp
                en or ja

        $scope.subjects.setFilter subjectFilter


.controller 'AdminSubjectDetailCtrl',
    ($scope, Subject, $state, $stateParams, Notify, NotFound) ->

        $scope.subject = $scope.subjects.retrieve $stateParams.id
        if not $scope.subject?
            NotFound()
            return

        $scope.deleting = false

        $scope.doDeleteSubject = ()->
            $scope.subject.$remove {}, (data)->
                $scope.subjects.remove $scope.subject
                $state.go 'admin.subject'
                Notify '削除しました。', type: 'danger'

        $scope.deleteSubject = ()->
            if $scope.deleting
                $scope.doDeleteSubject()
            else
                $scope.deleting = true

        $scope.stopDeleting = ->
            $scope.deleting = false


.controller 'AdminSubjectEditCtrl',
    ($scope, Subject, $state, $stateParams, Notify) ->
        $scope.editing = $scope.subject?.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        if $scope.editing
            $scope.newSubject = angular.copy $scope.subject
        else
            $scope.newSubject = new Subject()

        $scope.errors = {}

        onError = (res)->
            Notify '入力にエラーがあります。', type: 'warn'
            $scope.errors = res.data.errors

        $scope.doSaveSubject = (valid)->
            if valid
                if $scope.editing
                    $scope.newSubject.$update {}, (data)->
                        $scope.subjects.set data
                        $state.go 'admin.subject.detail', {id: data.id}
                        Notify '保存しました。'
                    , onError
                else
                    $scope.newSubject.$save {}, (data)->
                        $scope.subjects.set data
                        $state.go 'admin.subject.detail', {id: data.id}
                        Notify '新規作成しました。'
                    , onError
            else
                Notify '入力にエラーがあります。', type: 'warn'

