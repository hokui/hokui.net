
module.exports = (Vue)->
    vm = new Vue
        template: do require './index.jade'
        methods:
            show: ->
                @$$.loader.classList.add 'loader-active'
                @$$.overlay.classList.add 'overlay-active'
            hide: ->
                @$$.loader.classList.remove 'loader-active'
                @$$.overlay.classList.remove 'overlay-active'

    loader = (v)->
        if v? and not v
            vm.hide()
        else
            vm.show()

    vm.$mount().$appendTo document.body

    # Vue.router.on '$pageUpdating', ->
    #     vm.hide()

    Vue.loader = loader
    Vue.prototype.$loader = loader
