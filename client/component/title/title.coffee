'use strict'

angular.module moduleComponent

.provider 'Title', ->
    _default = ''
    setDefault: (title)->
        _default = title

    $get: ($rootScope)->
        _title = _default
        $rootScope.$on '$stateChangeSuccess', (ev, toState, toParams, fromState, fromParams)->
            if t = toState.data?.title
                _title = t
            else
                _title = _default

        (title)->
            if title?
                _title = title
            else
                _title
            _title

.run ($rootScope, Title)->
    $rootScope.Title = Title
