'use strict'

angular.module moduleCore

.factory 'Semester',
    ($resource) ->
        $resource "/api/semesters/:id", {id: '@id'},
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

            remove:
                method: 'DELETE'




