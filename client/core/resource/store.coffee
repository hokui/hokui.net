'use strict'

angular.module moduleCore

.factory 'ResourceStore',
    ->
        (base)->
            angular.extend base,
                retrieve: (pk, pk_name)->
                    if not pk_name?
                        pk_name = 'id'
                    for obj in this
                        if ''+obj[pk_name] is ''+pk
                            return obj
                    null

                set: (obj)->
                    if obj.id?
                        _obj = @retrieve obj.id
                    else
                        throw new Error 'Tried to set object which does not have id field.'

                    if _obj?
                        angular.extend _obj, obj
                    else
                        this.push obj

                del: (obj)->
                    i = this.indexOf obj
                    if i > -1
                        this.splice i, 1
