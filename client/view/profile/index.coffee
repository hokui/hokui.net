Vue = require 'vue'

ClassYear = require '../../resource/class_year'

u = require '../../lib/util'
userSetting = (require '../../lib/store').local.userSetting


module.exports = Vue.extend
    template: do require './index.jade'
    data: ->
        errors: {}
        user: @$auth.user()
        userSetting: userSetting.get()

        viewMode: 'detail'
    computed:
        cyLabel: ->
            if @classYears
                (ClassYear.retrieve id: @user.class_year_id).year + '期'
            else
                ''

    methods:
        performSaveSetting: (e)->
            e.preventDefault()

            userSetting.set @userSetting
            @$toast '設定を更新しました'

    created: ->
        @$resolve
            classYears: ClassYear.get()

        @$on '$pageUpdated', (context, next)=>
            @viewMode = next.data.mode
