'use strict'

angular.module @serviceName

.factory 'ClassYear',
    ($resource, IDRetrieve) ->
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




