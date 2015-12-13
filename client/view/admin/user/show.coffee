Vue = require 'vue'

User = require '../../../resource/user'

module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        you: @$auth.user()

        viewMode: 'detail'

    ready: ->
        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode or 'detail'
            @$resolve
                user: User.find id: (Number @$context().params.id)
