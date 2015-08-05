slugList = [
    'xs'
    'sm'
    'md'
    'lg'
]

responsive =
    xs: false
    sm: false
    md: false
    lg: false

module.exports = (Vue)->
    vm = new Vue
        replace: true
        template: '<div class="responsive-width-getter"></div>'
        data:
            responsive: responsive
        methods:
            clear: ->
                @responsive.xs = false
                @responsive.sm = false
                @responsive.md = false
                @responsive.lg = false

            onResize: (apply)->
                @clear()
                style = @$el.currentStyle or window.document.defaultView.getComputedStyle @$el, ''
                if idx = slugList[style['zIndex']]
                    responsive[idx] = true

        attached: ->
            window.addEventListener 'resize', =>
                @onResize()

            @onResize()

    vm.$mount().$appendTo document.body

    Vue.responsive = vm.responsive
    Vue.prototype.$useResponsive = (name)->
        if not name
            name = 'responsive'
        if not @$get name
            @$add name, vm.responsive
