config = require '../config'


setting = {}

getSetting = ->
    JSON.parse localStorage.getItem config.settingStorageKey

setSetting = (s)->
    localStorage.setItem config.settingStorageKey, JSON.stringify s

resetSetting = ->
    setSetting {}

trimSetting = ->
    s = getSetting()
    s2 = {}
    for k, part of setting
        s2[k] = s[k]
    setSetting s2

do ->
    if str = localStorage.getItem config.settingStorageKey
        try
            JSON.parse str
        catch
            resetSetting()
    else
        resetSetting()



class Part
    constructor: (@name, defaultValue, overwrite)->
        setting[@name] = this
        if overwrite or not @get()?
            @set defaultValue

    set: (v)->
        s = getSetting()
        s[@name] = v
        setSetting s
    get: ->
        getSetting()[@name]

new Part 'useTargetBlank', true
new Part 'signupRequested', false
new Part 'classYearTransformOption',
    sort: 'id'
    inverted: false
, true
new Part 'userTransformOption',
    sort: 'id'
    inverted: false
    filter:
        status: 'all'
        search:
            text: ''
            handleName: true
            fullName: true
            email: true
        classYearId: 0
, true

new Part 'subjectTransformOption',
    sort: 'id'
    inverted: false
    filter:
        search:
            text: ''
            titleEn: true
            titleJa: true
, true

trimSetting()

module.exports = setting
