'use strict'

describe 'ResourceStore', ->

    obj1 = obj2 = obj3 = objects = resources = null

    beforeEach ->
        obj1 =
            id: 1
            text: 'obj1'
        obj2 =
            id: 2
            text: 'obj2'
        obj3 =
            id: 3
            text: 'obj3'

        objects = [obj1, obj2, obj3]

        module moduleCore

        inject (ResourceStore)->
            resources = new ResourceStore objects

    it 'init', inject ->
        expect resources.original
        .toBe objects

    it 'retrieve', inject ->
        expect resources.retrieve 1
        .toBe obj1

        expect resources.retrieve 'obj1', 'text'
        .toBe obj1

        expect resources.retrieve 100
        .toBe null


    it 'set to add',inject ->
        obj10 =
            id: 10
            text: 'obj10'

        expect resources.set obj10
        .toBe true

        expect resources.retrieve 10
        .toBe obj10

    it 'set to extend', inject ->
        new_obj2 =
            id: 2
            text: 'new obj2'

        expect resources.set new_obj2
        .toBe false

        expect obj2.text
        .toBe new_obj2.text

    it 'set no id object',inject ->
        obj =
            text : 'has no id'
        try
            resources.set obj
            expect(true).toBe false
        catch e
            expect(true).toBe true

    it 'remove', inject ->
        expect resources.remove obj2
        .toBe true
        expect resources.remove obj2
        .toBe false

        expect resources.retrieve 1
        .toBe obj1
        expect resources.retrieve 2
        .toBe null
        expect resources.retrieve 3
        .toBe obj3

    it 'remove by id', inject ->
        expect resources.removeById 2
        .toBe true
        expect resources.removeById 2
        .toBe false

        expect resources.retrieve 2
        .toBe null

    it 'same reference', inject ->
        obj1.text = 'modified obj1'
        expect resources.retrieve(1).text
        .toBe 'modified obj1'

        retrieved_obj2 = resources.retrieve 2
        retrieved_obj2.text = 'modified obj2'
        expect obj2.text
        .toBe retrieved_obj2.text

describe 'ResourceFilter', ->
    filter1 = filter1_1 = filter1_2 = filter1_3 = filters = null
    obj1 = obj2 = obj3 = resources = null

    beforeEach ->
        module moduleCore

        inject (ResourceStore)->
            obj1 =
                filteredBy: ['1_2']
            obj2 =
                filteredBy: ['1_1', '1_2']
                value: 'PIYO'
            obj3 =
                filteredBy: ['1_1']
            obj4 =
                filteredBy: ['1_1', '1_2']
                value: 'HOGE'

            resources = new ResourceStore [obj1, obj2, obj3, obj4]

    describe 'basic', ->
        beforeEach ->
            inject (ResourceFilter)->
                filter1 = new ResourceFilter
                filter1_1 = new ResourceFilter
                    parent: filter1
                    label: '1_1'
                    slug: 'slug_1_1'
                    filter: (obj)->
                        _.includes obj.filteredBy, '1_1'
                filter1_2 = new ResourceFilter
                    parent: filter1
                    label: '1_2'
                    slug: 'slug_1_2'
                    filter: (obj)->
                        _.includes obj.filteredBy, '1_2'
                filter1_3 = new ResourceFilter
                    parent: filter1
                    label: '1_3'
                    slug: 'slug_1_3'
                    value: 'HOGE'
                    filter: (obj)->
                        obj.value is @value
                filters = [filter1, filter1_1, filter1_2, filter1_3]


        it 'filter init', inject ->
            expect filter1.active()
            .toBe true
            expect filter1_1.active()
            .toBe true
            expect filter1_2.active()
            .toBe true

            expect filter1_1.label
            .toBe '1_1'
            expect filter1.findBySlug 'slug_1_2'
            .toBe filter1_2


        it 'perform filter', inject ->
            resources.setFilter filter1
            filter1_1.active false
            filter1_2.active false
            filter1_3.active false
            result = -> resources.transformed()

            expect result().length
            .toBe 4

            filter1_1.active true
            expect result().length
            .toBe 3

            filter1_2.active true
            expect result().length
            .toBe 2

            filter1_3.active true
            expect result().length
            .toBe 1

            filter1_3.value = 'FUGA'
            expect result().length
            .toBe 0

            filter1_3.value = 'PIYO'
            expect result().length
            .toBe 1

            filter1.active false
            expect result().length
            .toBe 4


    describe 'alternative', ->
        beforeEach ->
            inject (ResourceFilter)->
                filter1 = new ResourceFilter
                    alternative: true
                filter1_1 = new ResourceFilter
                    parent: filter1
                    filter: (obj)->
                        _.includes obj.filteredBy, '1_1'
                filter1_2 = new ResourceFilter
                    parent: filter1
                    filter: (obj)->
                        _.includes obj.filteredBy, '1_2'
                filter1_3 = new ResourceFilter
                    parent: filter1
                    value: 'HOGE'
                    filter: (obj)->
                        obj.value is @value
                filters = [filter1, filter1_1, filter1_2, filter1_3]

        it 'activity', inject ->
            expect _.map filters, (el)-> el.active()
            .toEqual [false, false, false, false]

            filter1_2.active true

            expect _.map filters, (el)-> el.active()
            .toEqual [true, false, true, false]

            filter1_3.active true

            expect _.map filters, (el)-> el.active()
            .toEqual [true, false, false, true]

            filter1_3.active false

            expect _.map filters, (el)-> el.active()
            .toEqual [false, false, false, false]

        it 'perform filter', inject ->
            resources.setFilter filter1
            result = -> resources.transformed()

            expect result().length
            .toBe 4

            filter1_1.active true
            expect result().length
            .toBe 3

            filter1_2.active true
            expect result().length
            .toBe 3

            filter1_3.active true
            expect result().length
            .toBe 1

            filter1_1.active true
            expect result().length
            .toBe 3

describe 'ResourceSorter', ->
    obj1 = obj2 = obj3 = resources = null
    sorter1 = sorter2 = sorter3 = filter = null

    beforeEach ->
        module moduleCore

        inject (ResourceStore)->
            obj1 =
                id: 1
                name: 'うえだ'
                type: 'A'
            obj2 =
                id: 2
                name: 'いのうえ'
                type: 'B'
            obj3 =
                id: 3
                name: 'あおき'
                type: 'A'

            resources = new ResourceStore [obj1, obj2, obj3]

        inject (ResourceSorter, ResourceFieldSorter, ResourceFilter)->
            sorter1 = new ResourceFieldSorter ['name']
            sorter2 = new ResourceFieldSorter ['type', 'name']
            sorter3 = new ResourceSorter()

            filter = new ResourceFilter
                filter: (obj)->
                    obj.type is 'A'

    it 'basic', inject ->
        result = -> resources.transformed()

        resources.setSorter sorter1
        expect result()
        .toEqual [obj3, obj2, obj1]


        resources.setSorter sorter2
        expect result()
        .toEqual [obj3, obj1, obj2]

        resources.setSorterOrInverse sorter2
        expect result()
        .toEqual [obj2, obj1, obj3]

        resources.setSorter sorter3
        resources.inverted true
        expect result()
        .toEqual [obj3, obj2, obj1]

    it 'integrated with filter', inject ->
        result = -> resources.transformed()

        expect result()
        .toEqual [obj1, obj2, obj3]

        resources.setFilter filter

        expect result()
        .toEqual [obj1, obj3]

        resources.setSorter sorter2
        expect result()
        .toEqual [obj3, obj1]

        filter.active false

        expect result()
        .toEqual [obj3, obj1, obj2]
