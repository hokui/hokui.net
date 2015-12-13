config = require '../config'

currentStorage = sessionStorage

module.exports = (Vue)->
    http = Vue.http

    setHeader = (token)->
        http.headers.common[config.authHeaderName] = config.authTokenPrefix + token

    if not localStorage or not sessionStorage
        alert 'ブラウザが古すぎます。アップデートしましょう。'
        throw new Error 'Your browser is too old.'

    if t = sessionStorage.getItem config.tokenStorageKey
        currentStorage = sessionStorage
    else
        if t = localStorage.getItem config.tokenStorageKey
            currentStorage = localStorage
        else
            t = ''
            currentStorage = sessionStorage
    if t
        setHeader t

    Vue.token = Vue.prototype.$token =
        set: (token, useLocalStorage)->
            @clear()
            currentStorage = if useLocalStorage then localStorage else sessionStorage
            currentStorage.setItem config.tokenStorageKey, token
            setHeader token
        get: ->
            (currentStorage.getItem config.tokenStorageKey) or ''
        exists: ->
            !!@get()
        clear: ->
            currentStorage.removeItem config.tokenStorageKey
            delete http.headers.common[config.authHeaderName]
        header: ->
            token = @get()
            if token
                "#{config.authHeaderName}": token
            else
                {}
