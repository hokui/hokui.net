Vue = require 'vue'

Collection = require '../../../lib/collection'

User = require '../../../resource/user'
ClassYear = require '../../../resource/class_year'
# transformOption = (require '../../../lib/store').session.userTransformOption

class UserCollection extends Collection
    statusValue = (u)->
        if u.admin
            return 1
        else
            if u.approval_state is 'approved'
                return 10
            else
                if u.activation_state is 'active'
                    return 100
                else
                    return 1000

    sort_by_id: (a, b)->
        a.id - b.id
    sort_by_cy: (a, b)->
        a.class_year_id - b.class_year_id
    sort_by_status: (a, b)->
        (statusValue a) - (statusValue b)

    filter_by_status: (value)->
        switch value
            when 'pending'
                (user)-> user.activation_state is 'pending'
            when 'waiting'
                (user)->
                    user.activation_state is 'active' and user.approval_state is 'waiting'
            when 'admin'
                (user)-> user.admin
            else
                (user)-> true

    filter_by_text: (value)->
        r = new RegExp tex
        (user)->
            if not text
                return true
            if r.test user.handle_name
                return true
            if r.test user.full_name
                return true
            if r.test user.email
                return true
            false

    filter_by_cy: (value)->
        (user)->
            if value > 0
                user.class_year_id is value
            else
                return true


User.addFilter 'classYearId', (value)->
    (user)->
        if value > 0
            user.class_year_id is value
        else
            return true


module.exports = Vue.extend
    template: do require './list.jade'
    data: ->
        statusFilters:
            all: 'すべて'
            pending: 'メール承認待ち'
            waiting: '管理人承認待ち'
            admin: '管理者'
        a: ''
    methods:
        iconType: (name)->
            if @users.sorted name
                if @users.reversed()
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

        digest: ->
            @_digest()

    created: ->
        @$resolve
            classYears: ClassYear.get()
            users: User.get().then (items)->
                 new UserCollection items

    resolved: ->
        console.log users.filtered 'status'
        @$watch 'users', ->
            console.log 'ch'
        , deep: true

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
