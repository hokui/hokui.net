'use strict'

angular.module('hokuiApp').config([
    '$stateProvider',
    ($stateProvider) ->
        $stateProvider.state(
            'main',
            url: '/',
            templateUrl: 'app/main/main.html'
            controller: 'MainCtrl'
        )
])
