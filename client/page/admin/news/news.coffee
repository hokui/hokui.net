'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider

    .state 'admin.news',
        url: '/news',
        views:
            'main@admin':
                templateUrl: '/page/admin/news/news.html'
                controller: 'AdminNewsCtrl'

            'main@admin.news':
                templateUrl: '/page/admin/news/list.html'
                controller: 'AdminNewsListCtrl'
        resolve:
            newss: (News, ResourceStore)->
                News.query().$promise.then (data)->
                    new ResourceStore data


    .state 'admin.news.new',
        url: '/new',
        views:
            'main@admin.news':
                templateUrl: '/page/admin/news/edit.html'
                controller: 'AdminNewsEditCtrl'

    .state 'admin.news.detail',
        url: '/{id:int}',
        views:
            'main@admin.news':
                templateUrl: '/page/admin/news/detail.html'
                controller: 'AdminNewsDetailCtrl'

    .state 'admin.news.detail.edit',
        url: '/edit',
        views:
            'edit@admin.news.detail':
                templateUrl: '/page/admin/news/edit.html'
                controller: 'AdminNewsEditCtrl'


.controller 'AdminNewsCtrl',
    ($scope, newss) ->
        $scope.newss = newss

.controller 'AdminNewsListCtrl',
    ($scope)->


.controller 'AdminNewsDetailCtrl',
    ($scope, $stateParams, Notify, NotFound)->
        $scope.news = $scope.newss.retrieve $stateParams.id
        if not $scope.news?
            NotFound()
            return

        $scope.deleting = false

        $scope.doDeleteNews = ()->
            $scope.news.$remove {}, (data)->
                $scope.newss.remove $scope.news
                $state.go 'admin.news'
                Notify '削除しました。', type: 'danger'

        $scope.deleteNews = ()->
            if $scope.deleting
                $scope.doDeleteNews()
            else
                $scope.deleting = true

        $scope.stopDeleting = ->
            $scope.deleting = false


.controller 'AdminNewsEditCtrl',
    ($scope, $state, Notify, News)->
        $scope.editing = $scope.news?.id?

        if $scope.editing
            $scope.newNews = angular.copy $scope.news
        else
            $scope.newNews = new News()

        $scope.errors = {}

        onError = (res)->
            Notify '入力にエラーがあります。', type: 'warn'
            $scope.errors = res.data.errors

        $scope.doSaveNews = (valid)->
            if valid
                if $scope.editing
                    $scope.newNews.$update {}, (data)->
                        $scope.newss.set data
                        $state.go 'admin.news.detail', {id: data.id}
                        Notify '保存しました。'
                    , onError
                else
                    $scope.newNews.$save {}, (data)->
                        $scope.newss.set data
                        $state.go 'admin.news.detail', {id: data.id}
                        Notify '新規作成しました。'
                    , onError
            else
                Notify '入力にエラーがあります。', type: 'warn'
