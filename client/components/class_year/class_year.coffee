'use strict'

angular.module serviceName

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

            save:
                method: 'POST'




