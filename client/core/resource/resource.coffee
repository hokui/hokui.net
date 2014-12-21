'use strict'

angular.module moduleCore

.factory 'ResourceStore',
    ->
        (base)->
            angular.extend base,
                retrieve: (id)->
                    for obj in this
                        if ''+obj.id is ''+id
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
