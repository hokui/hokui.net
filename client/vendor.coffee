require 'normalize.css/normalize.css'
require 'font-awesome/css/font-awesome.css'
(require 'google-fonts').add 'Source Sans Pro': true


if /localhost/.test location.host
    require 'webpack-dev-server/client?http://localhost:9000'

require('es6-promise').polyfill()
require 'vue'
require 'vue-validator'
require 'vue-resource'
require 'page'
require 'moment'
require 'superagent'
require 'marked'
require 'eventemitter2'
