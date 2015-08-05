

module.exports = (Vue)->
    Vue.router.on '$pageUpdating', (context, next, past, status)->
        rule = next.data.rule
        if rule and not Vue.auth.can rule.level
            status.next = rule.next
            if m = rule.message
                Vue.toast m
