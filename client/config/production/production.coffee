'use strict'

angular.module moduleConfig

.config (EnvProvider)->
    EnvProvider
    .setApiRoot '/api'
    .setDev false

.config (AnalyticsProvider)->
    AnalyticsProvider.setAccount 'UA-30681632-1'
    AnalyticsProvider.trackPages true
    AnalyticsProvider.trackUrlParams true
    AnalyticsProvider.setDomainName 'hokui.net'
    AnalyticsProvider.useDisplayFeatures true
    AnalyticsProvider.setPageEvent '$stateChangeSuccess'
