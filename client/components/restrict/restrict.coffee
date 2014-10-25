'use strict'

angular.module serviceName

.factory 'Restriction',
    (Auth)->
        (state)->
            _default =
                error: '権限がありません。'
                next: 'main'

            _result =
                can: true

            if state.data?.restrict?
                restrict = state.data.restrict
                _result.can = Auth.can state.data.restrict.role

                if not _result.can
                    _result.error = restrict.error or _default.error
                    _result.next = restrict.next or _default.next

            _result





