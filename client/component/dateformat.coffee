moment = require 'moment'


module.exports = (Vue, options)->
    Vue.filter 'date', (date, format)->
        if date
            moment(date).format format
        else
            ''
