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
