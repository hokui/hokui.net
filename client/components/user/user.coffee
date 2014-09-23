'use strict'

angular.module appName

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
                transformRequest: (data)->
                    angular.toJson user: data



