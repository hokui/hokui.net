'use strict'

angular.module serviceName

.factory 'PageRestriction',
    ($state, Auth, Notify)->
        (to, from)->
            can = true
            if to.data?.restrict?
                restrict = to.data?.restrict
                needs_role = to.data.restrict.role
                error = restrict.error or '権限がありません。'
                next = restrict.next or false
                first_visit = from.name is ''
                can = Auth.can needs_role
                if not can
                    if next
                        $state.go next
                    else
                        if first_visit
                            $state.go 'main'
                    Notify error, type: 'warning', delay: if first_visit then 500 else 0

            can


