'use strict'

angular.module moduleCore

.factory 'DocumentFile',
    ($resource, Env) ->
        $resource "#{Env.apiRoot()}/document_files/:id",
            id: '@id'
        ,
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
