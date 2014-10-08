'use strict'

angular.module serviceName

.factory 'Subject',
    ($resource) ->
        $resource "/api/subjects/:id", {id: '@id'},
            get:
                method: 'GET'
                isArray: false

            query:
                method: 'GET'
                isArray: true

            update:
                method: 'PATCH'
                transformRequest: (data)->
                    angular.toJson subject: data

            save:
                method: 'POST'
                transformRequest: (data)->
                    angular.toJson subject: data




