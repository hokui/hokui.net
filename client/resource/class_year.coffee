Model = require '../lib/model'

ClassYear = new Model '/class_years/:id'

ClassYear.addSorter 'id', (a, b)-> a.id - b.id
ClassYear.addSorter 'year', (a, b)-> a.year - b.year

module.exports = ClassYear
