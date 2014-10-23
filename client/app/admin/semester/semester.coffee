'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.semester',
        url: '/semester?year&subject',
        views:
            'main@admin':
                templateUrl: '/app/admin/semester/semester.html'
                controller: 'AdminSemesterCtrl'
                resolve:
                    semesters: (Semester)->
                        Semester.query().$promise
                    class_years: (ClassYear)->
                        ClassYear.query().$promise
                    subjects: (Subject)->
                        Subject.query().$promise


            'main@admin.semester':
                templateUrl: '/app/admin/semester/list.html'
                controller: 'AdminSemesterListCtrl'

    .state 'admin.semester.detail',
        url: '/:id',
        views:
            'main@admin.semester':
                templateUrl: '/app/admin/semester/detail.html'
                controller: 'AdminSemesterDetailCtrl'

    .state 'admin.semester.detail.edit',
        url: '/edit',
        views:
            'edit@admin.semester.detail':
                templateUrl: '/app/admin/semester/edit.html'
                controller: 'AdminSemesterEditCtrl'


.controller 'AdminSemesterCtrl',
    ($scope, ResourceStore, semesters, class_years, subjects) ->
        $scope.semesters = ResourceStore semesters
        $scope.class_years = ResourceStore class_years
        $scope.subjects = ResourceStore subjects


.controller 'AdminSemesterListCtrl',
    ($scope, $state, $stateParams, Retriever) ->

        $scope.indexOfClassYear = [
            index: 0
            text: 'すべて表示'
            filter: ''
        ]
        i = 1
        for year in $scope.class_years
            $scope.indexOfClassYear.push
                index: i
                filter:
                    class_year_id: year.id
                text: "#{year.year}期"
                slug: year.year
            i = i + 1

        $scope.indexOfSubject = [
            index: 0
            text: 'すべて表示'
            filter: ''
        ]
        i = 1
        for subject in $scope.subjects
            $scope.indexOfSubject.push
                index: i
                filter:
                    subject_ids: [subject.id]
                text: subject.title_ja
                slug: subject.title_en
            i = i + 1


        $scope.selectIndexOfClassYear = (i)->
            $scope.currentIndexOfClassYear = $scope.indexOfClassYear[i]
            # $scope.currentIndexOfSubject = $scope.indexOfSubject[0]


        $scope.selectIndexOfSubject = (i)->
            $scope.currentIndexOfSubject = $scope.indexOfSubject[i]
            # $scope.currentIndexOfClassYear = $scope.indexOfSubject[0]


        if $stateParams.year?
            r = $scope.indexOfClassYear.filter (item, index)->
                ''+item.slug is ''+$stateParams.year
            i = if r.length is 1 then r[0].index else 0
            $scope.selectIndexOfClassYear i or 0
        else
            $scope.selectIndexOfClassYear 0

        if $stateParams.subject?
            r = $scope.indexOfSubject.filter (item, index)->
                item.slug is $stateParams.subject
            i = if r.length is 1 then r[0].index else 0

            $scope.selectIndexOfSubject i or 0
        else
            $scope.selectIndexOfSubject 0


        $scope.searchUrlForSubject = (i)->
            param = {}
            if $scope.indexOfSubject[i].slug?
                param.subject = $scope.indexOfSubject[i].slug
            $state.href '.', param, inherit: false

        $scope.searchUrlForClassYear = (i)->
            param = {}
            if $scope.indexOfClassYear[i].slug?
                param.year = $scope.indexOfClassYear[i].slug
            $state.href '.', param, inherit: false

.controller 'AdminSemesterDetailCtrl',
    ($scope, Semester, $state, $stateParams, Notify) ->
        semester_id = $stateParams.id

        if semester_id isnt ''
            $scope.semester = $scope.semesters.retrieve semester_id
            if not $scope.semester?
                $state.go 'admin.semester'
                Notify "Not found semester(id: \"#{semester_id}\")", type: 'warning'
        else
            $scope.semester = null

.controller 'AdminSemesterEditCtrl',
    ($scope, Semester, $state, $stateParams, Notify) ->
        $scope.editing = $scope.semester?.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        $scope.deleting = false

        if $scope.editing
            $scope.new_semester = angular.copy $scope.semester
        else
            $scope.new_semester = new Semester()
            $scope.new_semester.subject_ids = []

        $scope.doSaveSemester = ()->
            if $scope.editing
                $scope.new_semester.$update {}, (data)->
                    $scope.semesters.set data
                    $state.go 'admin.semester.detail', {id: data.id}
                    Notify '保存しました。'
            else
                $scope.new_semester.$save {}, (data)->
                    $scope.semesters.set data
                    $state.go 'admin.semester.detail', {id: data.id}
                    Notify '新規作成しました。'

        $scope.doDeleteSemester = ()->
            $scope.semester.$remove {}, (data)->
                $scope.semesters.del $scope.semester
                $state.go 'admin.semester'
                Notify '削除しました。', type: 'danger'

        $scope.deleteSemester = ()->
            console.log 'del'
            if $scope.deleting
                $scope.doDeleteSemester()
            else
                Notify 'もう一度クリックすると削除します。', type: 'danger'
                $scope.deleting = true

        $scope.stopDeleting = ->
            $scope.deleting = false
            Notify '削除を中断しました。', type: 'warning'

        $scope.deleteBtnLabel = ()->
            if $scope.deleting
                return "マジで削除する"
            else
                return '削除する'


        $scope.subjectCheckboxChange = (subject)->
            idx = $scope.new_semester.subject_ids.indexOf subject.id
            if idx > -1
                $scope.new_semester.subject_ids.splice idx, 1
            else
                $scope.new_semester.subject_ids.push subject.id



