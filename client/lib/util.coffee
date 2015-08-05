randomBase = 'abcdefghijklmnopqrstuvwxyz0123456789'.split ''

module.exports =
    randomString: (l)->
        result = ''
        for i in [1..l]
            result += randomBase[Math.floor(Math.random()*randomBase.length)];
        result
