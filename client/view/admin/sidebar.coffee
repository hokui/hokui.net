Vue = require 'vue'


module.exports = Vue.extend
    template: do require './sidebar.jade'
    data: ->
        items: [
            href: '/admin'
            label: 'TOP'
            active: /^\/admin$/
        ,
            href: '/admin/user'
            label: 'ユーザー'
            active: /^\/admin\/user/
        ,
            href: '/admin/class_year'
            label: '学年'
            active: /^\/admin\/class_year/
        ,
            href: '/admin/subject'
            label: '教科'
            active: /^\/admin\/subject/
        ,
            href: '/admin/semester'
            label: 'カリキュラム'
            active: /^\/admin\/semester/
        ,
            href: '/admin/news'
            label: 'お知らせ'
            active: /^\/admin\/news/
        ]
        activeItemIndex: -1

    created: ->
        @$on '$pageUpdated', =>
            @activeItemIndex = -1
            for i, item of @items
                if item.active.test @$context().path
                    @activeItemIndex = i
                    break
