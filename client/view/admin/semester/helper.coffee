ClassYear = require '../../../resource/class_year'
Subject = require '../../../resource/subject'

module.exports =
    # name: (semester, short)->
    #     grade = semester.identifier.substr 0, 1
    #     ab = semester.identifier.substr 1, 1
    #     sem = switch ab
    #         when 'a'
    #             '前'
    #         when 'b'
    #             '後'
    #         else
    #             ''
    #
    #     cy = ClassYear.retrieve id: semester.class_year_id
    #     year = if cy then cy.year else 'n/a'
    #     if short
    #         "#{cy.year}-#{grade}#{sem}"
    #     else
    #         "#{cy.year}期の#{grade}年#{sem}期"

    year: (semester)->
        (ClassYear.retrieve id: semester.class_year_id).year
    name: (semester, short)->
        grade = semester.identifier.substr 0, 1
        sem = switch semester.identifier.substr 1, 1
            when 'a'
                '前'
            when 'b'
                '後'
            else
                ''
        if short
            "#{grade}#{sem}"
        else
            "#{grade}年#{sem}期"


    subjects: (semester)->
        Subject.retrieve id: semester.subject_ids, true
