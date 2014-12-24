'use strict'

angular.module moduleComponent

.directive 'match', ($parse)->
    require: 'ngModel'
    link: (scope, elem, attrs, ctrl)->
        scope.$watch ->
            target = $parse(attrs.match) scope
            v = not ctrl.$modelValue or target is ctrl.$modelValue
        , (currentValue)->
            ctrl.$setValidity 'match', currentValue


.directive 'forceInvalid', ($parse)->
    require: 'ngModel'
    link: (scope, elem, attrs, ctrl)->
        scope.$watch ->
            not $parse(attrs.forceInvalid) scope
        , (currentValue)->
            ctrl.$setValidity 'force', currentValue
