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

    .state 'admin.year.detail',
        url: '/:id',
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
        $scope.classYears = ResourceStore classYears



.controller 'AdminYearListCtrl',
    ($scope, ClassYear) ->


.controller 'AdminYearDetailCtrl',
    ($scope, ClassYear, $state, $stateParams, Notify) ->
        year_id = $stateParams.id

        if year_id isnt ''
            $scope.classYear =$scope.classYears.retrieve year_id
            if not $scope.classYear?
                $state.go 'admin.year'
                Notify "Not found class_year(id: \"#{year_id}\")", type: 'warning'

        $scope.deleting = false

        $scope.doDeleteYear = ->
            $scope.classYear.$remove {}, (data)->
                $scope.classYears.del $scope.classYear
                $state.go 'admin.year'
                Notify '削除しました。', type: 'danger'

        $scope.deleteYear = ->
            if $scope.deleting
                $scope.doDeleteYear()
            else
                $scope.deleting = true

        $scope.stopDeleting = ->
            $scope.deleting = false

        $scope.deleteBtnLabel = ->
            if $scope.deleting
                return "マジで削除する"
            else
                return '削除する'


.controller 'AdminYearEditCtrl',
    ($scope, ClassYear, $state, $stateParams, Notify) ->
        $scope.editing = $scope.classYear?.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        if $scope.editing
            $scope.new_year = angular.copy $scope.classYear
        else
            $scope.new_year = new ClassYear()

        $scope.errors = {}

        onError = (res)->
            Notify '入力にエラーがあります。', type: 'warn'
            $scope.errors = res.data.errors

        $scope.doSaveYear = (valid)->
            if valid
                if $scope.editing
                    $scope.new_year.$update {}, (data)->
                        $scope.classYears.set data
                        $state.go 'admin.year.detail', {id: data.id}
                        Notify '保存しました。'
                    , onError
                else
                    $scope.new_year.$save {}, (data)->
                        $scope.classYears.set data
                        $state.go 'admin.year.detail', {id: data.id}
                        Notify '新規作成しました。'
                    , onError
            else
                Notify '入力にエラーがあります。', type: 'warn'






