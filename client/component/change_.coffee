module.exports = (Vue, options)->

    _ = Vue.util

    Vue.directive 'change',
        acceptStatement: true
        priority: 801
        update: (fn)->
            model = @el.getAttribute Vue.config.prefix + 'model'
            radio = false
            checkbox = false
            number = false
            @handler = ((v)->
                cache = @vm.$value
                if model
                    @vm.$value = v
                else
                    v = @el.value
                    if checkbox
                        @vm.$value = @el.checked
                    else if number
                        @vm.$value = _.toNumber v
                    else
                        @vm.$value = v
                fn @vm.$value
                @vm.$value = cache
            ).bind this

            if model
                @vm.$watch model, @handler
            else
                type = @el.getAttribute 'type'
                radio = type is 'radio'
                checkbox = type is 'checkbox'
                number = !!@el.getAttribute 'number'

                if radio or checkbox
                    @el.addEventListener 'change', @handler
                else
                    @el.addEventListener 'input', @handler

        unbind: ->
            @el.removeEventListener 'input', @handler
