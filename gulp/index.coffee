global.g = require 'gulp'
global.$ = do require 'gulp-load-plugins'
global.conf = require './conf'
global.onError = require './error'


require './clean'
require './copy'
require './build-css'
require './build-html'
require './build-js'
require './build'
require './serve'
require './watch'
require './rails'
require './e2e'

g.task 'default', ['watch', 'rails']
