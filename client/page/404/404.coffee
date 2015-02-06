'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state '404',
        url: '/404?url'
        templateUrl: '/page/404/404.html'
        controller: '404Ctrl'
        data:
            title: '北医ネット - ページが見つかりません'

.controller '404Ctrl',
    ($scope, $state, $stateParams, NotFound) ->
        if url = $stateParams.url
            $scope.message = "<code>#{url}</code>は存在しないページです。"
        else
            NotFound()
