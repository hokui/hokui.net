'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'study',
        url: '/study'
        templateUrl: '/page/study/study.html'
        controller: 'StudyCtrl'
        data:
            restrict:
                role: 'user'
                error: '/study 以下へアクセスするにはログインしてください。'
                next: 'login'

.controller 'StudyCtrl',
    ($scope) ->


