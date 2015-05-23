'use strict'

describe 'Resource', ->
    ResourceStore = ResourceFilter = ResourceFieldSorter = ResourceSorter = null

    beforeEach ->
        module moduleCore
        inject (_ResourceStore_, _ResourceFilter_, _ResourceFieldSorter_, _ResourceSorter_)->
            ResourceStore = _ResourceStore_
            ResourceFilter = _ResourceFilter_
            ResourceFieldSorter = _ResourceFieldSorter_
            ResourceSorter = _ResourceSorter_

    it 'init store', ->
        list = [1, 2, 3]
        resources = new ResourceStore list
        expect resources.original
        .toBe list

    it 'init store error', ->
        list = 'string'
        try
            resources = new ResourceStore list
            expect true
            .toBe false
        catch e
            expect true
            .toBe true


    describe 'ResourceStore', ->
        obj1 = obj2 = obj3 = objects = resources = null

        beforeEach ->
            obj1 =
                id: 1
                text: 'obj1'
                type: 'A'
            obj2 =
                id: 2
                text: 'obj2'
                type: 'B'
            obj3 =
                id: 3
                text: 'obj3'
                type: 'B'
            objects = [obj1, obj2, obj3]

            resources = new ResourceStore objects


        it 'retrieve', ->
            expect resources.retrieve 1
            .toBe obj1

            expect resources.retrieve 'obj3', 'text'
            .toBe obj3

            # get first macth element
            expect resources.retrieve 'B', 'type'
            .toBe obj2

            expect resources.retrieve 100
            .toBe null


        it 'set to add',->
            obj10 =
                id: 10
                text: 'obj10'

            expect resources.set obj10
            .toBe true

            expect resources.retrieve 10
            .toBe obj10


        it 'set to extend', ->
            new_obj2 =
                id: 2
                text: 'new obj2'

            expect resources.set new_obj2
            .toBe false

            expect obj2
            .not.toBe new_obj2
            expect obj2
            .toEqual
                id: 2
                text: 'new obj2'
                type: 'B'


        it 'set no id object',->
            obj =
                text : 'has no id'
            try
                resources.set obj

                expect true
                .toBe false
            catch e
                expect true
                .toBe true


        it 'remove', ->
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


        it 'remove by id', ->
            expect resources.removeById 2
            .toBe true
            expect resources.removeById 2
            .toBe false

            expect resources.retrieve 2
            .toBe null
            expect resources.count()
            .toBe 2


        it 'same reference', ->
            obj1.text = 'modified obj1'
            expect resources.retrieve(1).text
            .toBe 'modified obj1'

            retrieved_obj2 = resources.retrieve 2
            retrieved_obj2.text = 'modified obj2'
            expect obj2.text
            .toBe retrieved_obj2.text


        it 'get map', ->
            mapId = resources.getMap()
            expect mapId[obj2.id]
            .toBe obj2

            # when the values are not uniq, map will be truncated
            mapType = resources.getMap 'type'
            expect mapType
            .toBe null

        it 'transformed', ->
            expect resources.transformed()
            .not.toBe objects
            expect resources.transformed()
            .toEqual objects

            resources.inverted true

            expect resources.transformed()[0]
            .toEqual obj3


    describe 'ResourceFilter not alternative', ->
        obj1 = obj2 = obj3 = obj4 = resources = null

        beforeEach ->
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


        describe 'ResourceFilter not alternative', ->
            filter1 = filter1_1 = filter1_2 = filter1_3 = filters = null

            beforeEach ->
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


            it 'filter init', ->
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

                expect filter1.children().length
                .toBe 3

            it 'perform filter', ->
                resources.setFilter filter1
                expect resources.getFilter()
                .toBe filter1

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

                filter1.active true
                expect result().length
                .toBe 1

                resources.clearFilter filter1
                expect result().length
                .toBe 4


        describe 'ResourceFilter alternative', ->
            filter1 = filter1_1 = filter1_2 = filter1_3 = filters = null

            beforeEach ->
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


            it 'activity', ->
                expect _.map filters, (el)-> el.active()
                .toEqual [false, false, false, false]

                filter1.active true
                expect _.map filters, (el)-> el.active()
                .toEqual [true, true, false, false]

                filter1.active false
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


            it 'perform filter', ->
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
        sorter1 = sorter2 = sorter3 = sorter4 = filter = null

        beforeEach ->
            obj1 =
                id: 1
                name: 'うえだ'
                type: 'A'
                value: 9
            obj2 =
                id: 2
                name: 'いのうえ'
                type: 'B'
                value: 3
            obj3 =
                id: 3
                name: 'あおき'
                type: 'A'
                value: 6

            resources = new ResourceStore [obj1, obj2, obj3]

            sorter1 = new ResourceFieldSorter ['name']
            sorter2 = new ResourceFieldSorter ['type', 'name']
            sorter3 = new ResourceSorter()
            sorter4 = new ResourceFieldSorter ['value']

            filter = new ResourceFilter
                filter: (obj)->
                    obj.type is 'A'


        it 'basic', ->
            result = -> resources.transformed()

            resources.setSorter sorter1
            expect result()
            .toEqual [obj3, obj2, obj1]
            expect resources.getSorter()
            .toBe sorter1
            expect resources.inverted()
            .toBe false

            resources.setSorter sorter2
            resources.setSorter sorter2
            expect result()
            .toEqual [obj3, obj1, obj2]
            expect resources.inverted()
            .toBe false

            resources.setSorterOrInverse sorter2
            expect result()
            .toEqual [obj2, obj1, obj3]
            expect resources.inverted()
            .toBe true

            resources.setSorterOrInverse sorter3
            expect result()
            .toEqual [obj1, obj2, obj3]
            expect resources.inverted()
            .toBe false

            resources.inverted true
            expect result()
            .toEqual [obj3, obj2, obj1]
            expect resources.inverted()
            .toBe true

            resources.setSorterOrInverse sorter3
            expect result()
            .toEqual [obj1, obj2, obj3]
            expect resources.inverted()
            .toBe false

            resources.clearSorter()
            expect result()
            .toEqual [obj1, obj2, obj3]
            expect resources.inverted()
            .toBe false

            resources.setSorter sorter4
            expect result()
            .toEqual [obj2, obj3, obj1]
            expect resources.inverted()
            .toBe false


        it 'integrated with filter', ->
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
