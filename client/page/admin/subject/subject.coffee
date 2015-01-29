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

    .state 'admin.subject.detail',
        url: '/:id',
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
        $scope.subjects = ResourceStore subjects


.controller 'AdminSubjectListCtrl',
    ($scope, ResourceFilterItem, ResourceFilterGroup) ->
        $scope.predicate = 'id'
        $scope.reversed = false

        $scope.orderBy = (field)->
            if $scope.predicate is field
                $scope.reversed = not $scope.reversed
            else
                $scope.predicate = field
                $scope.reversed = false

        $scope.titleFilter = new ResourceFilterItem
            search: (model)->
                exp = new RegExp @value
                en = model.title_en.match exp
                ja = model.title_ja.match exp
                en or ja

        $scope.subjectFilter = new ResourceFilterGroup()
        .add $scope.titleFilter


.controller 'AdminSubjectDetailCtrl',
    ($scope, Subject, $state, $stateParams, Notify) ->

        if subject_id = $stateParams.id
            $scope.subject = $scope.subjects.retrieve subject_id
            if not $scope.subject?
                $state.go 'admin.subject'
                Notify "Not found subject has id: #{subject_id}", type: 'warn'
        else
            if $state.current.name is not 'admin.subject.detail.edit'
                $state.go 'admin.subject'

        $scope.deleting = false

        $scope.doDeleteSubject = ()->
            $scope.subject.$remove {}, (data)->
                $scope.subjects.del $scope.subject
                $state.go 'admin.subject'
                Notify '削除しました。', type: 'danger'

        $scope.deleteSubject = ()->
            if $scope.deleting
                $scope.doDeleteSubject()
            else
                $scope.deleting = true

        $scope.stopDeleting = ->
            $scope.deleting = false

        $scope.deleteBtnLabel = ()->
            if $scope.deleting
                return "マジで削除する"
            else
                return '削除する'


.controller 'AdminSubjectEditCtrl',
    ($scope, Subject, $state, $stateParams, Notify) ->
        $scope.editing = $scope.subject?.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        if $scope.editing
            $scope.new_subject = angular.copy $scope.subject
        else
            $scope.new_subject = new Subject()

        $scope.errors = {}

        onError = (res)->
            Notify '入力にエラーがあります。', type: 'warn'
            $scope.errors = res.data.errors

        $scope.doSaveSubject = (valid)->
            if valid
                if $scope.editing
                    $scope.new_subject.$update {}, (data)->
                        $scope.subjects.set data
                        $state.go 'admin.subject.detail', {id: data.id}
                        Notify '保存しました。'
                    , onError
                else
                    $scope.new_subject.$save {}, (data)->
                        $scope.subjects.set data
                        $state.go 'admin.subject.detail', {id: data.id}
                        Notify '新規作成しました。'
                    , onError
            else
                Notify '入力にエラーがあります。', type: 'warn'

