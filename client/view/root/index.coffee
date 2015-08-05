Vue = require 'vue'

auth = require '../../lib/auth'

module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        active: @$auth.active()
        isSidebarOpen: false
        items: [
            href: '/'
            label: 'HOME'
            icon: 'home'
            active: /^\/$/
        ,
            href: '/study'
            label: 'STUDY'
            icon: 'book'
            active: /^\/study/
        ,
            href: '/admin'
            label: 'ADMIN'
            icon: 'wrench'
            active: /^\/admin/
        ,
            href: '/profile'
            label: 'PROFILE'
            icon: 'user'
            active: /^\/profile/
        ,
            href: '/logout'
            label: 'LOGOUT'
            icon: 'sign-out'
            active: /^\/logout/
        ]
        activeItemIndex: -1
        usingSidebar: false
    methods:
        sidebarToggle: ->
            if @isSidebarOpen
                @closeSidebar()
            else
                @openSidebar()

        openSidebar: ->
            @isSidebarOpen = true

        closeSidebar: ->
            @isSidebarOpen = false

        ttt: (v)->
            typeof v

    created: ->
        @$useResponsive()

    attached: ->
        @$on '$pageUpdated', =>
            @activeItemIndex = -1
            for i, item of @items
                if item.active.test @$context().path
                    @activeItemIndex = i
                    break

            @usingSidebar = @$router.views['sidebar_content']?
            @closeSidebar()

        window.addEventListener 'resize', @closeSidebar

    detached: ->
        window.removeEventListener 'resize', @closeSidebar
