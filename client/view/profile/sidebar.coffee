Vue = require 'vue'


module.exports = Vue.extend
    template: do require './sidebar.jade'
    data: ->
        items: [
            href: '/profile'
            label: '詳細'
            active: /^\/profile$/
        ,
            href: '/profile/edit'
            label: '編集'
            active: /^\/profile\/edit$/
        ,
            href: '/profile/setting'
            label: '設定'
            active: /^\/profile\/setting$/

        ]
        activeItemIndex: -1

    created: ->
        @$on '$pageUpdated', =>
            @activeItemIndex = -1
            for i, item of @items
                if item.active.test @$context().path
                    @activeItemIndex = i
                    break
