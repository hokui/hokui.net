randomBase = 'abcdefghijklmnopqrstuvwxyz0123456789'.split ''

errorMap =
    'has already been taken': 'すでに使われています'
    'can\'t be blank': '必須入力項目です'
    'is invalid': '不正な形式です'


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

    parseError: (errors)->
        n = {}
        for k, v of errors
            es = []
            for i, e of v
                if map[e]
                    es.push map[e]
                else
                    es.push e
            n[k] = es
        n
