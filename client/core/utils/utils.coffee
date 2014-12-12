'use strict'

angular.module moduleCore

.factory 'Retriever',
    () ->
        (list, pk, pk_field)->
            if not pk_field?
                pk_field = 'id'
            for obj in list
                if ''+obj[pk_field] is ''+pk
                    return obj
            null

.directive 'textbox', ($compile)->
    restrict: 'E'
    link: (scope, element, attrs)->
        element.attr 'contenteditable', true



