'use strict'

angular.module moduleCore

.factory 'DocumentFile',
    ($resource, Env) ->
        $resource "#{Env.apiRoot()}/subjects/:subject_id/documents/:document_id/Document_file/:id",
            id: '@id'
        ,
            get:
                method: 'GET'
                isArray: false

            save:
                method: 'POST'

            update:
                method: 'PATCH'

            remove:
                method: 'DELETE'
