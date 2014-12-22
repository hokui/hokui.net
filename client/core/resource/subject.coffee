'use strict'

angular.module moduleCore

.factory 'Subject',
    ($resource, Env) ->
        $resource "#{Env.apiRoot()}/subjects/:id", {id: '@id'},
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
