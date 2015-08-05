module.exports = (Vue, options)->
    Vue.directive 'editable',
        twoWay: true
        updatePlaceholder: (text)->
            if @placeholder and text
                if @el.getAttribute 'placeholder'
                    @el.setAttribute 'placeholder', ''
            else
                if not @el.getAttribute 'placeholder'
                    @el.setAttribute 'placeholder', @placeholder
        bind: ->
            @placeholder = @el.getAttribute 'placeholder'

            @el.setAttribute 'contenteditable', true
            @handler = (->
                text = @el.innerText
                @set text
                @updatePlaceholder text
            ).bind this
            @el.addEventListener 'input', @handler
        update: (value)->
            @updatePlaceholder value
            if _.isString value
                @el.innerText = value
        unbind: ->
            @el.removeEventListener 'input', @handler
