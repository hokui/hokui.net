'use strict'

angular.module @appName
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.year',
        url: '/year',
        views:
            'main@admin':
                templateUrl: '/app/admin/year/year.html'
                controller: 'AdminYearCtrl'
                resolve:
                    years: (ClassYear)->
                        ClassYear.query().$promise

            'main@admin.year':
                templateUrl: '/app/admin/year/list.html'
                controller: 'AdminYearListCtrl'

    .state 'admin.year.detail',
        url: '/:id',
        views:
            'main@admin.year':
                templateUrl: '/app/admin/year/detail.html'
                controller: 'AdminYearDetailCtrl'

    .state 'admin.year.detail.edit',
        url: '/edit',
        views:
            'edit@admin.year.detail':
                templateUrl: '/app/admin/year/edit.html'
                controller: 'AdminYearEditCtrl'


.controller 'AdminYearCtrl',
    ($scope, years, ResourceStore) ->
        $scope.years = ResourceStore years



.controller 'AdminYearListCtrl',
    ($scope, ClassYear) ->


.controller 'AdminYearDetailCtrl',
    ($scope, ClassYear, $state, $stateParams, Notify) ->
        year_id = $stateParams.id

        if year_id isnt ''
            $scope.year =$scope.years.get year_id
            if not $scope.year?
                $state.go 'admin.year'
                Notify "Not found class_year(id: \"#{year_id}\")", type: 'warning'


.controller 'AdminYearEditCtrl',
    ($scope, ClassYear, $state, $stateParams, Notify) ->
        $scope.editing = $scope.year?.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        $scope.deleting = false

        $scope.new_year = new ClassYear()
        if $scope.editing
            angular.extend $scope.new_year, $scope.year

        $scope.doSaveYear = ()->
            if $scope.editing
                $scope.new_year.$update {}, (data)->
                    $scope.years.set data.id, data
                    $state.go 'admin.year.detail', {id: data.id}
                    Notify '保存しました。'
            else
                $scope.new_year.$save {}, (data)->
                    $scope.years.add data
                    $state.go 'admin.year.detail', {id: data.id}
                    Notify '新規作成しました。'

        $scope.doDeleteYear = ()->
            $scope.year.$remove {}, (data)->
                $scope.years.del $scope.year
                $state.go 'admin.year'
                Notify '削除しました。', type: 'danger'

        $scope.deleteYear = ()->
            if $scope.deleting
                $scope.doDeleteYear()
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




