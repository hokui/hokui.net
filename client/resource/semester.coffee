Model = require '../lib/model'

Semester = new Model '/semesters/:id'

Semester.addSorter 'id', (a, b)-> a.id - b.id

Semester.addFilter 'classYearId', (value)->
    (semester)->
        if value > 0
            semester.class_year_id is value
        else
            return true

Semester.addFilter 'grade', (value)->
    (semester)->
        if value
            semester.identifier.substr(0,1) is ''+value
        else
            return true

Semester.addFilter 'semester', (value)->
    (semester)->
        if value
            semester.identifier.substr(1,1) is value
        else
            return true

Semester.addFilter 'subjectIds', (value)->
    (semester)->
        if not Array.isArray value
            return true

        for id in value
            if (semester.subject_ids.indexOf id) > -1
                return true

        false

module.exports = Semester
