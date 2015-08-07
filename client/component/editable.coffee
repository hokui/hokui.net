module.exports = (Vue, options)->
    Vue.directive 'editable',
        twoWay: true
        updatePlaceholder: (text)->
            if @defaultPlaceholder and @el.innerText
                if @el.getAttribute 'placeholder'
                    @el.setAttribute 'placeholder', ''
            else
                if not @el.getAttribute 'placeholder'
                    @el.setAttribute 'placeholder', @defaultPlaceholder
        bind: ->
            @el.setAttribute 'contenteditable', true
            @defaultPlaceholder = @el.getAttribute 'placeholder'

            @handler = (->
                @set @el.innerText
                @updatePlaceholder()
            ).bind this
            @el.addEventListener 'input', @handler
        update: (value)->
            @el.innerText = value
            @updatePlaceholder()
        unbind: ->
            @el.removeEventListener 'input', @handler
