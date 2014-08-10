'use strict'

angular.module('hokuiApp').factory 'User', [
    '$resource', 'Token',
    ($resource, Token) ->
        $resource "/api/users/:id", {id: '@_id'},
            get:
                method: 'GET'
                isArray: false

]
