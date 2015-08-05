require './style/index.sass'

require './polyfill'

Vue = require 'vue'
Vue.config.debug = process.env.NODE_ENV isnt 'production'
Vue.use require 'vue-validator'
Vue.use require 'vue-resource'

Vue.use require './lib/router'
Vue.use require './lib/auth'
Vue.use require './lib/loader'
Vue.use require './lib/toast'
Vue.use require './lib/responsive'

Vue.use require './component/datebind'
Vue.use require './component/dateformat'
Vue.use require './component/datebadge'
Vue.use require './component/editor'
Vue.use require './component/loading'

Vue.router.route require './route'

(require './lib/handler/trailing_slash') Vue
(require './lib/handler/rule') Vue
(require './lib/handler/fix_href') Vue
(require  './lib/handler/title') Vue

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
