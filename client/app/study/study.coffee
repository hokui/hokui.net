'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'study',
        url: '/study'
        templateUrl: '/app/study/study.html'
        controller: 'StudyCtrl'
        data:
            restrict:
                role: 'user'
                error: '/study 以下へアクセスするにはログインしてください。'
                next: 'login'

.controller 'StudyCtrl',
    ($scope) ->


