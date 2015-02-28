'use strict'

angular.module moduleCore

.provider 'Restrict', ->
    _default_error = 'You have no permission to access the page.'
    _default_next = null

    defaultError: (error)->
        if _.isString
            _default_error = error
        _default_error

    defaultNext: (next)->
        if _.isString next
            _default_next = next
        _default_next

    $get: (Auth)->
        if not _default_next?
            throw new Error 'Need to set default state to be redirect to'

        (state)->
            _result =
                can: true

            if state.data?.restrict?
                restrict = state.data.restrict
                _result.can = Auth.can restrict.role

                if not _result.can
                    _result.error = restrict.error or _default_error
                    _result.next = restrict.next or _default_next

            _result
