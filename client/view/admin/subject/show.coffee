Vue = require 'vue'

Subject = require '../../../resource/subject'

module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        resolved: false
        subject: null
        viewMode: 'detail'


    ready: ->

        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode

            Subject.find id: (Number @$context().params.id), (item)=>
                @resolved = true
                @subject = item
