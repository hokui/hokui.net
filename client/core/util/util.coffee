'use strict'

angular.module moduleCore

.directive 'textbox', ->
    restrict: 'E'
    link: (scope, element, attrs)->
        element.attr 'contenteditable', true


.filter 'range', ->
    (input, min, max)->
        input.push(i) for i in [parseInt(min)..parseInt(max)]
        input


.factory 'NotFound', ($state, $location)->
    ->
        $state.transitionTo '404', {url: $location.absUrl()}, location: false


.factory 'Grade', ->
    (entrance)->
        year = (new Date()).getFullYear()
        if (new Date()).getMonth < 4
            year = year -1
        year - entrance - 1917


.provider 'Download', ->
    a = document.createElement 'a'
    a.style.display = 'none'
    a.target = '_blank'
    a.appendChild document.createTextNode ''
    document.body.appendChild(a);

    $get: ->
        (url, filename)->
            a.href = url
            a.download = filename
            a.click()
