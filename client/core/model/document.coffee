'use strict'

angular.module moduleCore

.factory 'Document',
    ($resource, Env) ->
        $resource "#{Env.apiRoot()}/subjects/:subject_id/documents", {},
            get:
                method: 'GET'
                isArray: false

            query:
                method: 'GET'
                isArray: true
