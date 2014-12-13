'use strict'

angular.module moduleCore

.factory 'ResourceStore',
    (Retriever)->
        (base)->
            angular.extend base,
                retrieve: (id)->
                    Retriever this, id, 'id'

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
