EventEmitter2 = (require 'eventemitter2')
u = require '../util'

ee = new EventEmitter2()
pendings = []
vms = []

baseResolver =
    append: (promise)->
        pendings.push promise

resolver = u.extend ee, baseResolver

resolveAsPromise = (vm, promise)->
    opt = vm.$options

    pendings.push promise.then (results)->
        for key, result of results
            if typeof result is 'undefined'
                e = new Error "You resolve undefined by `#{keyMap[i]}`"
                console.warn e.stack
            vm.$set key, result
        vm.$set 'resolved', true
        if typeof opt.resolved is 'function'
            opt.resolved.call vm
    , (err)->
        vm.$set 'rejected', true
        if typeof opt.rejected is 'function'
            opt.rejected.call vm, err


resolveAsDict = (vm, dictPromises)->
    opt = vm.$options

    keyMap = []
    promises = []
    for k, v of dictPromises
        vm.$add k
        keyMap.push k
        promises.push v

    pending = Promise.all promises
    .then (results)->
        for i, result of results
            if typeof result is 'undefined'
                e = new Error "You resolve undefined by `#{keyMap[i]}`"
                console.warn e.stack
            vm.$set keyMap[i], result
        vm.$set 'resolved', true
        if typeof opt.resolved is 'function'
            opt.resolved.call vm
    , (err)->
        vm.$set 'rejected', true
        if typeof opt.rejected is 'function'
            opt.rejected.call vm, err
        throw err

    pendings.push pending


module.exports = (Vue, options)->

    Vue.router.on '$pageUpdated', ->
        if pendings.length is 0
            return

        resolver.emit '$resolving'

        Promise.all pendings
        .then ->
            resolver.emit '$resolved'
            for vm in vms
                vm.$emit '$resolved'
            vms = []
            pendings = []
        , ->
            resolver.emit '$rejected'
            for vm in vms
                vm.$emit '$rejected'
            vms = []
            pendings = []

    Vue.resolver = resolver

    Vue.prototype.$resolve = (p1, p2)->
        vm = this
        vm.$add 'resolved'
        vm.$add 'rejected'
        vms.push vm

        if p1.__proto__.constructor is Promise
            resolveAsPromise vm, p1
            return

        if typeof p1 is 'object'
            resolveAsDict this, p1
            return

        throw new Error 'You provide invalid pram(s) to `$resolve()`'
