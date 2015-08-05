Vue = require 'vue'

User = require '../../../resource/user'
ClassYear = require '../../../resource/class_year'
setting = require '../../../lib/setting'



module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        users: null
        classYears: null

        transformOption: setting.userTransformOption.get()

        statusFilters:
            all:
                label: 'すべて'
            pending:
                label: 'メール承認待ち'
            waiting:
                label: '管理人承認待ち'
            admin:
                label: '管理者'
    methods:
        refresh: ->
            User.transformed @transformOption, (items)=>
                @users = items

        sortById: ->
            if @transformOption.sort is 'id'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'id'
                @transformOption.inverted = false

        sortByStatus: ->
            if @transformOption.sort is 'status'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'status'
                @transformOption.inverted = false

        sortByYear: ->
            if @transformOption.sort is 'classYear'
                @transformOption.inverted = not @transformOption.inverted
            else
                @transformOption.sort = 'classYear'
                @transformOption.inverted = false

        iconType: (name)->
            if @transformOption.sort is name
                if @transformOption.inverted
                    'fa-caret-down'
                else
                    'fa-caret-up'
            else
                'fa-sort'

        cyLabel: (id)->
            if @classYears.length > 0
                (ClassYear.retrieve id: id)?.year or ''
            else
                ''

    ready: ->
        @$watch 'transformOption', (v)->
            setting.userTransformOption.set v
            @refresh()
        , deep: true

        @refresh()

        ClassYear.get (items)=>
            @classYears = items

        console.log User.__filters.search

    filters:
        'omitDomain': (email)->
            email.replace /\.hokudai\.ac\.jp$/, ''

    components:
        'status-icon':
            props: ['user']
            template: do require './status-icon.jade'
            data: ->
                text: ''
            attached: ->
                if @user.admin
                    iconType = 'star'
                    iconColor = 'yellow'
                    @text = '管理者'
                else
                    if @user.approval_state is 'approved'
                        iconType = 'heart'
                        iconColor = 'pink'
                        @text = '一般ユーザー'
                    else
                        if @user.activation_state is 'active'
                            iconType = 'exclamation'
                            iconColor = 'green'
                            @text = 'クリックして承認'
                        else
                            iconType = 'times'
                            iconColor = ''
                            @text = 'メール認証待ち'

                if iconType
                    @$$.icon.classList.add 'baricon-'+iconType
                if iconColor
                    @$$.icon.classList.add 'baricon-'+iconColor
