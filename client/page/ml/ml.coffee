'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'ml',
        url: '/ml'
        templateUrl: '/page/ml/ml.html'
        controller: 'MlCtrl'
        data:
            restrict:
                role: 'user'
                error: '/ml 以下へアクセスするにはログインしてください。'
                next: 'login'

.controller 'MlCtrl',
    ($scope) ->
