
module.exports = (Vue, options)->
    Vue.prototype.$resolve = (p)->
        opt = @__proto__.constructor.options


        if typeof p isnt 'object'
            throw new Error 'Must provide object to `$resolve()`'
            return

        keyMap = []
        promises = []
        for k, v of p
            @$add k
            keyMap.push k
            promises.push v

        Promise.all promises
        .then (results)=>
            for i, result of results
                if typeof result is 'undefined'
                    e = new Error "You resolve undefined by `#{keyMap[i]}`"
                    console.warn e.stack
                @$set keyMap[i], result
            if typeof opt.resolved is 'function'
                opt.resolved.call this
        , (err)=>
            if typeof opt.rejected is 'function'
                opt.rejected.call this, err
