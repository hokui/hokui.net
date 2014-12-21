'use strict'

angular.module moduleCore

.factory 'Semester',
    ($resource, Env) ->
        $resource "#{Env.apiPath()}/semesters/:id", {id: '@id'},
            get:
                method: 'GET'
                isArray: false

            query:
                method: 'GET'
                isArray: true

            save:
                method: 'POST'

            update:
                method: 'PATCH'

            remove:
                method: 'DELETE'
