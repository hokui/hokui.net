
if not Number.isInteger
    Number.isInteger = (nVal)->
        typeof nVal is 'number' and isFinite(nVal) and nVal > -9007199254740992 and nVal < 9007199254740992 and Math.floor(nVal) is nVal
