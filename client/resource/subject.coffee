Model = require '../lib/model'

Subject = new Model '/subjects/:id'


Subject.addSorter 'id', (a, b)-> a.id - b.id
Subject.addSorter 'titleEn', (a, b)-> a.title_en.localeCompare b.title_en
Subject.addSorter 'titleJa', (a, b)-> a.title_ja.localeCompare b.title_ja

Subject.addFilter 'search', (value)->
    r = new RegExp value.text

    (subject)->
        if not value.text or (not value.titleJa and not value.titleEn)
            return true
        if value.titleJa
            if r.test subject.title_ja
                return true
        if value.titleEn
            if r.test subject.title_en
                return true
        false


module.exports = Subject
