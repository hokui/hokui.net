'use strict'

angular.module moduleCore

.factory 'User',
    ($resource, Env) ->
        $resource "#{Env.apiRoot()}/users/:id", {id: '@id'},
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
