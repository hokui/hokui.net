'use strict'

angular.module @serviceName

.factory 'IDRetrieve',
    () ->
        (list, pk, pk_field)->
            if not pk_field?
                pk_field = 'id'
            for obj in list
                if ''+obj[pk_field] is ''+pk
                    return obj
            return null

.factory 'ResourceStore',
    (IDRetrieve)->
        (base)->
            angular.extend base,
                get: (id)->
                    IDRetrieve this, id, 'id'

                set: (id, obj)->
                    _obj = @get id
                    angular.extend _obj, obj

                add: (obj)->
                    this.push obj

                del: (obj)->
                    i = this.indexOf obj
                    if i > -1
                        this.splice i, 1
