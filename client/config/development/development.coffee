'use strict'

angular.module moduleConfig

.config (EnvProvider)->
    EnvProvider
    .setApiRoot '/api'
    .setDev true

.config (AnalyticsProvider)->
    AnalyticsProvider.useAnalytics false
