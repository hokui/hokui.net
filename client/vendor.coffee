require 'normalize.css/normalize.css'
require 'font-awesome/css/font-awesome.css'


if /localhost/.test location.host
    require 'webpack-dev-server/client?http://localhost:9000'

# require('es6-promise').polyfill()
window._Promise = window.Promise
window.Promise = require 'bluebird'
require 'vue'
require 'vue-validator'
require 'vue-resource'
require 'page'
require 'moment'
require 'superagent'
require 'marked'
require 'eventemitter2'
