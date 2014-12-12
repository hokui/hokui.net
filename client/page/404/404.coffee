'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state '404',
        url: '/404?url'
        templateUrl: '/page/404/404.html'
        controller: '404Ctrl'

.controller '404Ctrl',
    ($scope, $state, $stateParams, $location) ->
        if not $scope.url = $stateParams.url
            $state.go 'home'
