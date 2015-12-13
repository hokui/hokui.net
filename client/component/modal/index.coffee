module.exports = (Vue, options)->

    Vue.component 'modal',
        replace: true
        template: do require './index.jade'
        props: ['open', 'title']
        methods:
            close: ->
                @open = false
            block: (e)->
                e.stopPropagation()

            # keydown: (e)=>
            #     # 27: ESC
            #     if e.keyCode is 27
            #         console.log @doClose
            #

        created: ->
            @keydown = ((e)->
                # 27: ESC
                if e.keyCode is 27
                    @close()
            ).bind this

            window.document.addEventListener 'keydown', @keydown

        destroyed: ->
            window.document.removeEventListener 'keydown', @keydown
