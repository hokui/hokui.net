'use strict'

angular.module moduleComponent

.directive 'responsiveWidthGetter', ($window, Responsive)->
    restrict: 'A'
    link: (scope, element, attrs)->
        slugList = [
            'xs'
            'sm'
            'md'
            'lg'
        ]
        clear = ->
            Responsive.xs = false
            Responsive.sm = false
            Responsive.md = false
            Responsive.lg = false

        onResize = (apply)->
            style = element[0].currentStyle or $window.document.defaultView.getComputedStyle element[0], ''
            clear()
            perform = ->
                Responsive[slugList[style['zIndex']]] = true

            if apply
                scope.$apply perform
            else
                perform()

        resizeTimer = null
        $window.addEventListener 'resize', ->
            if resizeTimer isnt null
                clearTimeout resizeTimer
            resizeTimer = setTimeout ->
                onResize true
            , 500

        onResize false

.factory 'Responsive', ->
    xs: false
    sm: false
    md: false
    ls: false
