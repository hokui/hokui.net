module.exports = (Vue, options)->
    Vue.component 'date-badge',
        props: ['value']
        template: do require './index.jade'
        data: ->
            date = new Date @value
            year: date.getFullYear()
            month: date.getMonth() + 1
            date: date.getDate()
