Vue = require 'vue'
config = require '../config'

module.exports = Vue.resource "#{config.api}/news/:id", {}, {},
    transformResponse: (res)->
        console.log res
        res.data
