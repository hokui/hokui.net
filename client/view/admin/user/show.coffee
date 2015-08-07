Vue = require 'vue'

User = require '../../../resource/user'

module.exports = Vue.extend
    template: do require './show.jade'
    data: ->
        you: @$auth.user()
        
        resolved: false
        user: null
        viewMode: 'detail'

    ready: ->
        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode or 'detail'

            User.find id: (Number @$context().params.id), (item)=>
                @resolved = true
                @user = item
