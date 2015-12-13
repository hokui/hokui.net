(function() {
  module.exports = function(Vue, options) {
    var _ = Vue.util

    return Vue.directive('change', {
      acceptStatement: true,
      priority: 900,

      /**
       * Possible elements:
       *   <select>
       *   <textarea>
       *   <input type="*">
       *     - text
       *     - checkbox
       *     - radio
       *   with number attribute
       */
      update: function (handler) {
        if (typeof handler !== 'function') {
          process.env.NODE_ENV !== 'production' && _.warn(
            'Directive v-change="' + this.expression +
            '" expects a function value, ' +
            'got ' + handler
          )
          return
        }
        var el = this.el
        var tag = el.tagName

        if (tag !== 'INPUT' && tag !== 'TEXTAREA' && tag !== 'SELECT') {
          process.env.NODE_ENV !== 'production' && _.warn(
            'v-change does not support element type: ' + tag
          )
          return
        }

        var vm = this.vm
        var modelName = _.attr(el, Vue.config.prefix + 'model') || null
        var radio = false
        var checkbox = false
        var select = false
        var number = false
        var multiple = false

        this.handler = function (param) {
          // with v-model: param is set model value
          // without v-model: param set Event object

          var cachedValue = vm.$value
          if (modelName) {
            vm.$value = param
          } else {
            if (select && multiple) {
              vm.$value = []
              var options = el.options
              var i = options.length
              while (i--) {
                if (options[i].selected) {
                  vm.$value.push(number
                    ? _.toNumber(options[i].value)
                    : options[i].value
                  )
                }
              }
            } else if (checkbox) {
              vm.$value = el.checked
            } else if (number) {
              vm.$value = _.toNumber(el.value)
            } else {
              vm.$value = el.value
            }
          }
          handler(vm.$value)
          // restore `$value` of vm.
          vm.$value = cachedValue
        }

        if (modelName) {
          // use $watch if with v-model
          this.unwatch = vm.$watch(modelName, this.handler)
        } else {
          radio = el.type === 'radio'
          checkbox = el.type === 'checkbox'
          select = tag === 'SELECT'
          multiple = el.hasAttribute('multiple')
          number = this._checkParam('number') != null

          this.eventName = radio || checkbox
            ? 'change'
            : 'input'

          _.on(this.el, this.eventName, this.handler)
        }
      },
      unbind: function () {
        if (this.eventName) {
          _.off(this.el, this.eventName, this.handler)
          return
        }
        if (this.unwatch) {
          this.unwatch()
        }
      }
    })
  }

}).call(this)
