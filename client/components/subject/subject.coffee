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




