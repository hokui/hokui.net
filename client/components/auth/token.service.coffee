'use strict'

angular.module('hokuiApp').factory('Token', [
    '$http', '$log','storage',
    ($http, $log, storage) ->
        token = storage.get('Access-Token')
        if token?
            $http.defaults.headers.common['Access-Token'] = token

        set: (t)->
            if t?
                $http.defaults.headers.common['Access-Token'] = t
                storage.set('Access-Token', t)
                token = t
            else
                @clear()
                $log.info('Called Token.set(token) with nil token, automatically clear() called')
        get: ()->
            token
        clear: ()->
            token = ''
            storage.remove('Access-Token')
            delete $http.defaults.headers.common['Access-Token']
])
