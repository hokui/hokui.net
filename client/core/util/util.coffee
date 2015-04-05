'use strict'

angular.module moduleCore

.directive 'textbox', ->
    restrict: 'E'
    link: (scope, element, attrs)->
        element.attr 'contenteditable', true


.filter 'range', ->
    (input, min, max)->
        input.push(i) for i in [parseInt(min)..parseInt(max)]
        input


.factory 'NotFound', ($state, $location)->
    ->
        $state.transitionTo '404', {url: $location.absUrl()}, location: false


.factory 'Grade', ->
    (entrance)->
        year = (new Date()).getFullYear()
        if (new Date()).getMonth < 4
            year = year -1
        year - entrance - 1917


.factory 'DownloadDocumentFile', ($http, Env, Notify)->
    (documentFile, suc, err)->
        console.log documentFile
        $http.get "#{Env.apiRoot()}/document_files/#{documentFile.id}/download_token"
        .success (data)->
            $http.get "/contents/document_files/#{documentFile.id}?download_token=#{data.token}",
                responseType: 'arraybuffer'
            .success (binary)->
                file = new Blob [binary], type: documentFile.file_content_type
                saveAs file, documentFile.file_name
                documentFile.download_count = documentFile.download_count + 1

