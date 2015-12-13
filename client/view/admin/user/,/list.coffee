Vue = require 'vue'

User = require '../../../resource/user'
ClassYear = require '../../../resource/class_year'
transformOption = (require '../../../lib/store').session.userTransformOption


module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        users: null
        tO: transformOption.get()

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
            User.transformed @tO
            .then (items)=>
                @users = items

        sortById: ->
            if @tO.sort is 'id'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'id'
                @tO.inverted = false

        sortByStatus: ->
            if @tO.sort is 'status'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'status'
                @tO.inverted = false

        sortByYear: ->
            if @tO.sort is 'classYear'
                @tO.inverted = not @tO.inverted
            else
                @tO.sort = 'classYear'
                @tO.inverted = false

        iconType: (name)->
            if @tO.sort is name
                if @tO.inverted
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
    created: ->
        @$resolve
            classYears: ClassYear.get()

    ready: ->
        @$watch 'tO', (v)->
            transformOption.set v
            @refresh()
        , deep: true

        @refresh()

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
