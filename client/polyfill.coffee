
if not Number.isInteger
    Number.isInteger = (nVal)->
        a = typeof nVal is 'number'
        a = a and isFinite(nVal)
        a = a and nVal > -9007199254740992
        a = a and nVal < 9007199254740992
        a = a and Math.floor(nVal) is nVal
        a
