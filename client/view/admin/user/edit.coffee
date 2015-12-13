Vue = require 'vue'

User = require '../../../resource/user'
parseError = require '../../../lib/parse_error'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        you: @$auth.user()
        classYears: []
        errors: {}
        editConfirmed: false
    validator:
        validates:
            spaceStartEnd: (v)->
                not /^( |　)|( |　)$/.test v
            mail: (v)->
                not v or /^\w+([\.-]?\w+)*@\w+([\.-]?\w+)*(\.\w{2,3})+$/.test v
            hokudaiMail: (v)->
                /^\w+([\.-]?\w+)*@(eis|med)\.hokudai\.ac\.jp$/.test v
    methods:
        performSave: (e)->
            e.preventDefault()

            @user.$save().then (item)=>
                @$router.go "/admin/user/#{item.id}"
                @$toast 'ユーザー情報を変更しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'

    created: ->
        @$resolve
            user: (User.find id: Number @$context().params.id).then (item)->
                item.$copy()
    resolved: ->
        @$watch 'user.handle_name', (e)=>
            @errors.handle_name = null
