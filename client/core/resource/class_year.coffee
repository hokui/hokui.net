'use strict'

angular.module moduleCore

.factory 'ClassYear',
    ($resource, Env) ->
        $resource "#{Env.apiPath()}/class_years/:id", {id: '@id'},
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
