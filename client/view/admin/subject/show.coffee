Vue = require 'vue'

Subject = require '../../../resource/subject'

module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        viewMode: 'detail'

    ready: ->
        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode
            @$resolve
                subject: Subject.find id: (Number @$context().params.id)
