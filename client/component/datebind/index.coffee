module.exports = (Vue, options)->

    Vue.component 'datebind',
        replace: true
        template: do require './index.jade'
        props:
            value:
                type: Date | String
                twoWay: true
        data: ->
            cache = new Date @value

            cache: cache
            years: do ->
                ys = []
                for y in [1950..2010]
                    ys.push
                        text: y + '年'
                        value: y
                ys
            months: do ->
                ms = []
                for m in [1..12]
                    ms.push
                        text: m + '月'
                        value: m - 1
                ms

            year: cache.getFullYear()
            month: cache.getMonth()
            date: cache.getDate()

        methods:
            getDates: ->
                last = (new Date(@cache.getFullYear(), @cache.getMonth() + 1, 0)).getDate()
                ds = []
                for d in [1..last]
                    ds.push
                        text: d + '日'
                        value: d
                ds

        created: ->
            @$data.$add 'dates', @getDates()

            @$watch 'year', (n)->
                v = new Date @cache
                v.setFullYear n
                @cache = v
            @$watch 'month', (n)->
                v = new Date @cache
                v.setMonth n
                @cache = v
            @$watch 'date', (n)->
                v = new Date @cache
                v.setDate n
                @cache = v

            @$watch 'cache', (n)->
                @dates = @getDates()

                @year = n.getFullYear()
                @month = n.getMonth()
                @date = n.getDate()

                if @value.__proto__?.constructor is Date
                    @value = @cache
                else
                    @value = "#{@year}-#{@month+1}-#{@date}"
