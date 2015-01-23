'use strict'

window.moduleComponent = 'hokuiComponent'

angular.module moduleComponent, [
    moduleCore
]

.run ($rootScope, Responsive)->
    $rootScope.Responsive = Responsive
