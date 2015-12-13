randomBase = 'abcdefghijklmnopqrstuvwxyz0123456789'.split ''

module.exports =
    randomString: (l)->
        result = ''
        for i in [1..l]
            result += randomBase[Math.floor Math.random() * randomBase.length]
        result

    extend: (a, b, copy)->
        target = if copy then (@extend {}, a, false) else a
        for k, v of b
            target[k] = v
        target

    copy: (arr)->
        c = new Array arr.length
        for i, v of arr
            c[i] = v


    reg:
        mail: /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/
