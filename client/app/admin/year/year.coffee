'use strict'

angular.module appName
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
    ($scope, ClassYear, years) ->
        console.log 'enter adminyear ctrl'
        $scope.years = years

.controller 'AdminYearListCtrl',
    ($scope, ClassYear) ->
        # noop

.controller 'AdminYearDetailCtrl',
    ($scope, ClassYear, $state, $stateParams, IDRetrieve) ->
        console.log 'enter detail ctrl'
        year_id = $stateParams.id

        if year_id isnt ''
                $scope.year = IDRetrieve($scope.years, year_id)
                if not $scope.year?
                    $scope.error = 'Not Found'
        else
            $scope.year = new ClassYear()



.controller 'AdminYearEditCtrl',
    ($scope, ClassYear, $state, $stateParams) ->
        $scope.editing = $scope.year.id?
        $scope.title = if $scope.editing then '編集' else '新規作成'

        reload = (state, params)->
            $state.transitionTo state, params,
                reload: true
                inherit: false
                notify: true

        $scope.saveYear = ->
            if $scope.editing
                $scope.year.$update {}, (data)->
                    reload 'admin.year.detail', {id: data.id}
            else
                $scope.year.$save {}, (data)->
                    reload 'admin.year.detail', {id: data.id}

        $scope.deleteYear = ->
            $scope.year.$remove {}, (data)->
                reload 'admin.year', {},


