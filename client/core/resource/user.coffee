'use strict'

angular.module moduleCore

.factory 'User',
    ($resource, Token) ->
        $resource "/api/users/:id", {id: '@id'},
            get:
                method: 'GET'
                isArray: false

            query:
                method: 'GET'
                isArray: true

            save:
                method: 'POST'

            remove:
                method: 'DELETE'
