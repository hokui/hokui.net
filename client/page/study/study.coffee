'use strict'

angular.module modulePage

.config ($stateProvider) ->
    $stateProvider
    .state 'study',
        url: '/study'
        views:
            '':
                templateUrl: '/page/study/study.html'
                controller: 'StudyCtrl'
            'main@study':
                templateUrl: '/page/study/main.html'
                controller: 'StudyMainCtrl'
        resolve:
            subjects: (Subject, ResourceStore)->
                Subject.query().$promise.then (data)->
                    new ResourceStore data

            semesters: (Auth, Semester, ResourceStore)->
                Semester.query
                    class_year_id: Auth.user().class_year_id
                .$promise.then (data)->
                    new ResourceStore data

            classYears: (ClassYear, ResourceStore)->
                ClassYear.query().$promise.then (data)->
                    new ResourceStore data

        data:
            restrict:
                role: 'user'
                message: '/study 以下へアクセスするにはログインしてください。'
                next: 'login'


.controller 'StudyCtrl',
    ($scope, Auth, $state, subjects, semesters, classYears, Grade)->
        $scope.subjects = subjects
        $scope.semesters = semesters
        $scope.classYears = classYears
        $scope.userClassYear = classYears.retrieve Auth.user().class_year_id

        map_ab =
            a: '前期'
            b: '後期'
        $scope.identifierMap = {}
        for grade in [2..6]
            for label in ['a','b']
                $scope.identifierMap["#{grade}#{label}"] = "#{grade}年#{map_ab[label]}"

        $scope.subjectMap = subjects.getMap()

        $scope.menuItems = []
        for semester in semesters.original
            $scope.menuItems.push
                open: false
                semester: semester

        $scope.toggleMenu = (menuItem)->
            menuItem.open = not menuItem.open


.controller 'StudyMainCtrl',
    ($scope, ResourceFilter, Grade)->
        grade = Grade $scope.userClassYear.year
        if 4 - 1 <= (new Date()).getMonth() <= 9 - 1
            currentSemester = "#{grade}a"
        else
            currentSemester = "#{grade}b"

        for item in $scope.menuItems
            item.open = item.semester.identifier is currentSemester


        $scope.subjectFilter = new ResourceFilter
            value: ''
            filter: (subject)->
                exp = new RegExp @value
                en = subject.title_en.match exp
                ja = subject.title_ja.match exp
                en or ja

        $scope.subjects.setFilter $scope.subjectFilter

        $scope.filterMessage = ""
        $scope.filteredSubject = null

        $scope.searchSubject = ->
            if $scope.subjectFilter.value
                result = $scope.subjects.transformed()
                $scope.filteredSubject = result
                if result.length > 0
                    $scope.filterMessage = "#{result.length}件見つかりました。"
                else
                    $scope.filterMessage = "該当する教科は見つかりませんでした。"
            else
                $scope.filteredSubject = null
                $scope.filterMessage = ""



