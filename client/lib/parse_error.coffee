map =
    'has already been taken': 'すでに使われています'
    'can\'t be blank': '必須入力項目です'
    'is invalid': '不正な形式です'

module.exports = (errors)->
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
