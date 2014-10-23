'use strict'

angular.module appName
.config ($stateProvider) ->
    $stateProvider
    .state 'help',
        url: '/help'
        templateUrl: '/app/help/help.html'
        controller: 'HelpCtrl'

.controller 'HelpCtrl',
    ($scope) ->
        $scope.email = 'hokui.net@gmail.com'

