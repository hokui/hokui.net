'use strict'

describe 'ResourceStore', ->


    resources = objects = obj1 = obj2 = obj3 = null

    beforeEach ->
        module moduleCore

        obj1 =
            id: '1'
            text: 'obj1'
        obj2 =
            id: '2'
            text: 'obj2'
        obj3 =
            id: '3'
            text: 'obj3'
        objects = [obj1, obj2]

        inject (ResourceStore)->
            resources = ResourceStore objects

    it 'retrieve', ->
        expect(resources.retrieve 1).toEqual obj1
        expect(resources.retrieve '1').toEqual obj1

    it 'set', ->
        # add
        resources.set obj3
        expect(resources.retrieve 3).toEqual obj3

        # set
        new_obj2 =
            id: '2'
            text: 'new obj2'
        resources.set new_obj2
        expect(resources.retrieve 2).toEqual new_obj2

        # error if try to set obj does not contain id field
        obj =
            text : 'no id field'
        try
            resources.set obj
            expect(false).toBe true
        catch e
            expect(true).toBe true



    it 'del', ->
        resources.del obj2
        expect(resources.retrieve 2).toBe null

        # no error even if resources does not contain object
        resources.del obj3

    it 'same reference', ->
        # modify origin object
        obj1.text = 'modified obj1'
        expect(resources.retrieve('1').text).toBe 'modified obj1'

        # modify retrieved object
        retrieved_obj2 = resources.retrieve '2'
        retrieved_obj2.text = 'modified obj2'
        expect(retrieved_obj2.text).toEqual obj2.text






