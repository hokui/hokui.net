'use strict'

angular.module moduleConfig

.config (EnvProvider)->
    login =
        email: 'admin@ec.hokudai.ac.jp'
        password:  'admin'

    signup =
        birthday: new Date 1990, 0, 1
        class_year_id : 1
        email: 'abe@ec.hokudai.ac.jp'
        email_mobile: 'abe@example.com'
        family_name: '阿部'
        given_name: '高和'
        handle_name: 'あべさん'
        password: 'yaranaika'

    EnvProvider
    .setSeed 'login', login
    .setSeed 'signup', signup
    .setDev true

.config (AnalyticsProvider)->
    AnalyticsProvider.useAnalytics false
