

module.exports = (Vue)->
    vm = new Vue
        template: do require './index.jade'
        data: ->
            message: ''
            period: -1
            timeoutId: null
        methods:
            cancelClosing: ->
                if @timeoutId
                    clearTimeout @timeoutId
                    @timeoutId = null

            open: (message, period)->
                @$el.classList.add 'toast-open'
                @message = message

                # auto close: not provided or set positive
                @period = Math.abs((parseInt period) or 4000)
                @cancelClosing()
                if @period > 0
                    @timeoutId = setTimeout =>
                        @close()
                    , @period

            close: ->
                @cancelClosing()
                @$el.classList.remove 'toast-open'

    vm.$mount().$appendTo document.body

    Vue.router.on '$pageUpdating', ->
        vm.close()

    toast = (message, period)->
        vm.open message, period

    Vue.toast = toast
    Vue.prototype.$toast = toast
