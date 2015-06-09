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

.filter 'bytes', ->
    (bytes, precision)->
        if isNaN(parseFloat(bytes)) or not isFinite bytes
            return '-'
        if not precision?
            precision = 1;
        units = ['bytes', 'kB', 'MB', 'GB', 'TB', 'PB']
        number = Math.floor(Math.log(bytes) / Math.log(1024))
        (bytes / Math.pow 1024, Math.floor number).toFixed(precision) +  ' ' + units[number]


.factory 'NotFound', ($state, $location)->
    ->
        $state.transitionTo '404', {url: $location.absUrl()}, location: false


.factory 'Grade', ->
    (entrance)->
        d = new Date()
        year = d.getFullYear()
        if d.getMonth < 4
            year = year -1
        year - entrance - 1917

.factory 'MaxClassYear', ->
    d = new Date()
    year = d.getFullYear()
    if d.getMonth < 4
        year = year -1
    year - 1918

.factory 'IsSmartPhone', ->
    iphone = navigator.userAgent.indexOf('iPhone') > 0
    ipad = navigator.userAgent.indexOf('iPad') > 0
    ipod = navigator.userAgent.indexOf('iPod') > 0
    android = navigator.userAgent.indexOf('Android') > 0
    windowsPhone = navigator.userAgent.indexOf('Windows Phone') > 0

    (iphone and not ipad) or ipod or android or windowsPhone


.directive 'bindModel', ($parse)->
    restrict: 'A'
    link: (scope, element, attrs)->
        target = element[0]

        mapGetter = $parse attrs.bindMap
        getMap = ->
            mapGetter scope

        performBind = (model)->
            if attrs.bindTrue and attrs.bindFalse
                if model
                    target.innerText = attrs.bindTrue
                else
                    target.innerText = attrs.bindFalse
                return
            else
                map = getMap()
                if map and angular.isObject(map) or angular.isArray(map)
                    if map[model]
                        target.innerText = map[model]
                        return
            target.innerText = ''

        scope.$watch attrs.bindModel, (newModel, oldModel)->
            performBind newModel
