require './style/index.sass'

require './polyfill'

(require './lib/font') 'Source Sans Pro': true
require './store'


Vue = require 'vue'
Vue.config.debug = process.env.NODE_ENV isnt 'production'
Vue.use require 'vue-validator'
Vue.use require 'vue-resource'

Vue.use require './lib/router'
Vue.use require './lib/auth'
Vue.use require './lib/loader'
Vue.use require './lib/toast'
Vue.use require './lib/responsive'
Vue.use require './lib/resolver'

Vue.use require './component/date-bind'
Vue.use require './component/date-format'
Vue.use require './component/date-badge'
Vue.use require './component/model-delete'
Vue.use require './component/editable'
Vue.use require './component/loading'
Vue.use require './component/modal'

Vue.router.route require './route'

(require './lib/handler/trailing_slash') Vue
(require './lib/handler/rule') Vue
(require './lib/handler/href') Vue
(require './lib/handler/title') Vue
(require './lib/handler/scroll') Vue


start = ->
    Vue.router.start()
    Vue.loader false

app = new Vue
    el: '#app'
    template: '<div v-view="root"></div>'

token = require './lib/token'
if token.exists()
    Vue.loader()
    Vue.auth.check().always start
else
    Vue.nextTick start
