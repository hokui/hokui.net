'use strict'

angular.module appName

.factory 'ClassYear',
    ($resource) ->
        $resource "/api/class_years/:id", {id: '@id'},
            get:
                method: 'GET'
                isArray: false

            query:
                method: 'GET'
                isArray: true

            update:
                method: 'PATCH'
                transformRequest: (data)->
                    angular.toJson class_year: data

            save:
                method: 'POST'
                transformRequest: (data)->
                    angular.toJson class_year: data


.factory 'ClassYearStore',
    (ClassYear) ->
        years: []
        get: ->
            ClassYear.query {}, (data)->
                @years = data

