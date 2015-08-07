makeArray = (arr)->
    Array.isArray(arr) ? arr : [arr]

getHref = (fonts)->
    family = Object.keys(fonts).map (name)->
        details = fonts[name]
        name = name.replace /\s+/g, '+'

        if typeof details is 'boolean'
            name
        else
            name + ':' + makeArray(details).join ','

    'http://fonts.googleapis.com/css?family=' + family.join '|'

module.exports = (fonts)->
    href = getHref fonts
    link = document.createElement 'link'
    link.setAttribute 'href', href
    link.setAttribute 'rel', 'stylesheet'
    document.head.appendChild link
