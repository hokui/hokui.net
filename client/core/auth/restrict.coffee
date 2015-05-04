'use strict'

angular.module moduleCore

.provider 'Restrict', ->
    _default_message = 'You have no permission to access the page.'
    _default_message_type = 'warn'
    _default_next = null

    defaultMessage: (message)->
        if _.isString
            _default_message = message
        _default_message

    defaultNext: (next)->
        if _.isString next
            _default_next = next
        _default_next


    $get: (Auth, $injector)->
        enabled: ->
            (_.isString _default_next) and _default_next isnt ''

        check: (state)->
            _result =
                can: true

            if state.data?.restrict
                restrict = state.data.restrict

                if restrict.role?
                    if _.isFunction restrict.rule
                        _result.can = !! restrict.rule $injector
                    else
                        _result.can = Auth.can restrict.role
                else
                    _result.can = false


                if not _result.can
                    _result.message = restrict.message or _default_message
                    _result.message_type = restrict.message_type or _default_message_type
                    _result.next = restrict.next or _default_next

            _result


.run ($rootScope, Restrict, $state, AuthChecker, Notify)->
    if not Restrict.enabled()
        return

    $rootScope.$on AuthChecker.altStateChangeStart(), (ev, toState, toParams, fromState, fromParams)->
        result = Restrict.check toState
        first_visit = fromState.name is ''
        if  not result.can
            setTimeout ->
                $state.go result.next
                if result.message isnt false
                    Notify result.message, type: result.message_type, delay: if first_visit then 500 else 0
            , 0
            ev.preventDefault()

