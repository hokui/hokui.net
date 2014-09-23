'use strict'

angular.module appName

.factory 'IDRetrieve',
    () ->
        (list, pk, pk_field)->
            if not pk_field?
                pk_field = 'id'
            for obj in list
                if ''+obj[pk_field] is ''+pk
                    return obj
            return null
