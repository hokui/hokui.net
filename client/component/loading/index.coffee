module.exports = (Vue, options)->

    Vue.component 'loading',
        replace: true
        template: do require './index.jade'
        props: ['show']
