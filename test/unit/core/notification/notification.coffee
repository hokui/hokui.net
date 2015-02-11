'use strict'

describe 'Notification', ->
    $timeout = $state = Notification = null
    beforeEach ->
        angular.module 'NotificationTestModule', [moduleCore]
        .config ($stateProvider) ->
            $stateProvider
            .state 'state',
                url: '/'
        module 'NotificationTestModule'

        inject (_$timeout_, _$state_, _Notification_)->
            Notification = _Notification_
            $state = _$state_
            $timeout = _$timeout_


    it 'show', ->
        Notification.show 'message'

        expect Notification.getMessage()
        .toBe 'message'

        expect Notification.visible()
        .toBe true

        $timeout.flush()

        expect Notification.visible()
        .toBe false

        $timeout.verifyNoPendingTasks()


    it 'hide', ->
        Notification.show ''

        Notification.hide()

        expect Notification.visible()
        .toBe false

        # even if $timeout promise is canceled, $timeout task is still alive
        $timeout.flush()
        $timeout.verifyNoPendingTasks()

    it 'delay', ->
        Notification.show '', delay: 1000

        expect Notification.visible()
        .toBe false

        $timeout.flush()

        expect Notification.visible()
        .toBe true

        $timeout.flush()

        expect Notification.visible()
        .toBe false

        $timeout.verifyNoPendingTasks()

    it 'not timeout to hide / hide when transit state', ->
        Notification.show '', period: -1

        $state.go 'state'

        expect Notification.visible()
        .toBe false


    it 'keep showing also when transit state', ->
        Notification.show '',
            period: -1
            autoHide: false

        $state.go 'state'

        expect Notification.visible()
        .toBe true


describe 'Notify', ->
    beforeEach ->
        module moduleCore

    it 'show', inject ($timeout, Notification, Notify)->
        Notify 'message'

        expect Notification.getMessage()
        .toBe 'message'

        expect Notification.visible()
        .toBe true

        $timeout.flush()

        expect Notification.visible()
        .toBe false

        $timeout.verifyNoPendingTasks()



