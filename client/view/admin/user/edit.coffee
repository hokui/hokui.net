Vue = require 'vue'

User = require '../../../resource/user'
parseError = require '../../../lib/parse_error'

module.exports = Vue.extend
    template: do require './edit.jade'
    data: ->
        you: @$auth.user()
        classYears: []
        user: null
        you: @$auth.user()
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

            @user.$save (item)=>
                @$router.go "/admin/user/#{item.id}"
                @$toast 'ユーザー情報を変更しました'
            , (err)=>
                @errors = parseError err.errors
                @$toast '入力にエラーがあります'


    ready: ->
        @editing = true
        if id = Number @$context().params.id
            User.find id: id, (item)=>
                @resolved = true
                @user = item.$copy()

                @$watch 'user.handle_name', (e)=>
                    @errors.handle_name = null
