'use strict'

angular.module moduleCore

.factory 'StorageSupported', (webStorage)->
    webStorage.local.isSupported and webStorage.session.isSupported

.factory 'StorageType', (webStorage, StorageSupported)->
    session: 1
    local: 2
    memory: 3
    all: -> [@session, @local, @memory]
    auto: (type)->
        t = parseInt type
        if t < 0 or 3 < t or isNaN t
            throw new Error 'Need to set the value 1 , 2 or 3. You provided ' + type

        if t < 3 and not StorageSupported
            t = @memory
        return t
