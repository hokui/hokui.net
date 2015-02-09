'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.year',
        url: '/year',
        views:
            'main@admin':
                templateUrl: '/page/admin/year/year.html'
                controller: 'AdminYearCtrl'
                resolve:
                    classYears: (ClassYear)->
                        ClassYear.query().$promise

            'main@admin.year':
                templateUrl: '/page/admin/year/list.html'
                controller: 'AdminYearListCtrl'

    .state 'admin.year.new',
        url: '/new',
        views:
            'main@admin.year':
                templateUrl: '/page/admin/year/edit.html'
                controller: 'AdminYearEditCtrl'

    .state 'admin.year.detail',
        url: '/{id:int}',
        views:
            'main@admin.year':
                templateUrl: '/page/admin/year/detail.html'
                controller: 'AdminYearDetailCtrl'

    .state 'admin.year.detail.edit',
        url: '/edit',
        views:
            'edit@admin.year.detail':
                templateUrl: '/page/admin/year/edit.html'
                controller: 'AdminYearEditCtrl'


.controller 'AdminYearCtrl',
    ($scope, classYears, ResourceStore) ->
        $scope.classYears = new ResourceStore classYears



.controller 'AdminYearListCtrl',
    ($scope, ClassYear) ->


.controller 'AdminYearDetailCtrl',
    ($scope, ClassYear, $state, $stateParams, Notify, NotFound) ->

        if not $scope.classYear = $scope.classYears.retrieve $stateParams.id
            NotFound()

        $scope.deleting = false

        $scope.doDeleteClassYear = ->
            $scope.classYear.$remove {}, (data)->
                $scope.classYears.del $scope.classYear
                $state.go 'admin.year'
                Notify '削除しました。', type: 'danger'

        $scope.deleteClassYear = ->
            if $scope.deleting
                $scope.doDeleteClassYear()
            else
                $scope.deleting = true

        $scope.stopDeleting = ->
            $scope.deleting = false


.controller 'AdminYearEditCtrl',
    ($scope, ClassYear, $state, $stateParams, Notify) ->
        $scope.editing = $scope.classYear?.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        if $scope.editing
            $scope.newClassYear = angular.copy $scope.classYear
        else
            $scope.newClassYear = new ClassYear()

        $scope.errors = {}

        onError = (res)->
            Notify '入力にエラーがあります。', type: 'warn'
            $scope.errors = res.data.errors

        $scope.doSaveClassYear = (valid)->
            if valid
                if $scope.editing
                    $scope.newClassYear.$update {}, (data)->
                        $scope.classYears.set data
                        $state.go 'admin.year.detail', {id: data.id}
                        Notify '保存しました。'
                    , onError
                else
                    $scope.newClassYear.$save {}, (data)->
                        $scope.classYears.set data
                        $state.go 'admin.year.detail', {id: data.id}
                        Notify '新規作成しました。'
                    , onError
            else
                Notify '入力にエラーがあります。', type: 'warn'






