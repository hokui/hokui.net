'use strict'

describe 'Ctrl Test', ->

    beforeEach ->
        module appName

        inject ($rootScope, $controller)->
            @$scope = $rootScope.$new()

            controller = $controller 'HelpCtrl',
                $scope: @$scope

    it 'help ctrl', ->
        expect(@$scope.email).toBe 'hokui.net@gmail.com'
