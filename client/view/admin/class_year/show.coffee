Vue = require 'vue'

ClassYear = require '../../../resource/class_year'

u = require '../../../lib/util'


module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        viewMode: 'detail'

    # created: ->
    #
    ready: ->
        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode
            @$resolve
                cy: ClassYear.find id: (Number @$context().params.id)
