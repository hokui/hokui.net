'use strict'

angular.module moduleConfig

.config (EnvProvider)->
    EnvProvider
    .setApiRoot '/api'
    .setDev false

.config (AnalyticsProvider)->
    AnalyticsProvider.setAccount 'UA-57572562-1'
    AnalyticsProvider.trackPages true
    AnalyticsProvider.setDomainName 'hokui.net'
    AnalyticsProvider.useDisplayFeatures true
    AnalyticsProvider.useAnalytics true
    AnalyticsProvider.setPageEvent '$stateChangeSuccess'
