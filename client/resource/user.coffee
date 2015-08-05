Model = require '../lib/model'

statusValue = (u)->
    if u.admin
        return 1
    else
        if u.approval_state is 'approved'
            return 10
        else
            if u.activation_state is 'active'
                return 100
            else
                return 1000

User = new Model '/users/:id'

User.addSorter 'id', (a, b)-> a.id - b.id
User.addSorter 'classYear', (a, b)-> a.class_year_id - b.class_year_id
User.addSorter 'status', (a, b)-> (statusValue a) - (statusValue b)


User.addFilter 'status', (value)->
    switch value
        when 'pending'
            (user)-> user.activation_state is 'pending'
        when 'waiting'
            (user)-> user.activation_state is 'active' and user.approval_state is 'waiting'
        when 'admin'
            (user)-> user.admin
        else
            (user)-> true

User.addFilter 'search', (value)->
    r = new RegExp value.text

    (user)->
        if not value.text or (not value.handleName and not value.fullName and not value.email )
            return true
        if value.handleName
            if r.test user.handle_name
                return true
        if value.fullName
            if r.test user.full_name
                return true
        if value.email
            if r.test user.email
                return true
        false

User.addFilter 'classYearId', (value)->
    (user)->
        if value > 0
            user.class_year_id is value
        else
            return true

module.exports = User
