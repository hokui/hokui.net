store = require './lib/store'

store.session.$add 'userTransformOption',
    sort: 'id'
    inverted: false
    filter:
        status: 'all'
        search:
            text: ''
            handleName: true
            fullName: true
            email: true
        classYearId: 0

store.session.$add 'classYearTransformOption',
    sort: 'id'
    inverted: false

store.session.$add 'subjectTransformOption',
    sort: 'id'
    inverted: false
    filter:
        search:
            text: ''
            titleEn: true
            titleJa: true

store.session.$add 'semesterTransformOption',
    sort: 'id'
    inverted: false
    filter:
        subjectIds: null
        classYearId: 0
        grade: null
        semester: null


store.session.$add 'newsTransformOption',
    sort: 'id'
    inverted: false


store.local.$add 'useTargetBlank', true
store.local.$add 'signupRequested', false

store.session.$trim()
store.local.$trim()
