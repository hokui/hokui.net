Model = require '../lib/model'

News = new Model '/news/:id'

News.addSorter 'id', (a, b)-> a.id - b.id

module.exports = News
