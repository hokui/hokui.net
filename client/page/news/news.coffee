'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'news',
        url: '/news'
        views:
            '':
                templateUrl: '/page/news/news.html'
                controller: 'NewsCtrl'

            'main@news':
                templateUrl: '/page/news/main.html'
                controller: 'NewsMainCtrl'
        resolve:
            newss: (News, ResourceStore)->
                News.query().$promise.then (data)->
                    new ResourceStore data
        data:
            restrict:
                role: 'user'
                error: '/news 以下へアクセスするにはログインしてください。'
                next: 'login'
            title: '北医ネット - おしらせ'


    .state 'news.detail',
        url: '/{id:int}',
        views:
            'main@news':
                templateUrl: '/page/news/detail.html'
                controller: 'NewsDetailCtrl'



.controller 'NewsCtrl',
    ($scope, newss) ->
        $scope.newss = newss

.controller 'NewsMainCtrl',
    ($scope)->
        null


.controller 'NewsDetailCtrl',
    ($scope, $stateParams, NotFound)->
        $scope.news = $scope.newss.retrieve $stateParams.id
        if not $scope.news?
            NotFound()
            return

