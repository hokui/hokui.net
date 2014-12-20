'use strict'

angular.module modulePage
.config ($stateProvider) ->
    $stateProvider
    .state 'upload',
        url: '/upload'
        templateUrl: '/page/upload/upload.html'
        controller: 'UploadCtrl'

.controller 'UploadCtrl',
    ($scope, $http) ->
        $scope.p = ->
            console.log $scope.files
            if not $scope.files
                return
            data =
                hoge: 'fuga'
            formData = new FormData()
            formData.append 'file', $scope.files[0]
            formData.append 'data', angular.toJson data
            $http.post '/api/document', formData,
                headers:
                    'Content-type': undefined
                transformRequest: null
            .success (res)->
                console.log res
            .error (res)->
                console.log res

.directive 'files', ->
    restrict : 'A'
    scope:
        files: '='
    link: (scope, element, attrs)->
        element.on 'change', (event)->
            scope.$apply ->
                scope.files = event.target.files
                console.log scope.files

