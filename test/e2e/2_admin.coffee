describe 'Admin', ->
    it 'sign in as admin and redirect to home', ->
        browser.get '/login'
        expect browser.getTitle()
        .toEqual '北医ネット - ログイン'

        email = element By.model 'credencials.email'
        email.sendKeys 'admin@ec.hokudai.ac.jp'
        password = element By.model 'credencials.password'
        password.sendKeys 'admin'

        form = element By.css 'form.form'
        form.submit()
        expect browser.getCurrentUrl()
        .toBe 'http://localhost:9000/'


    it 'study is accessable', ->
        browser.get '/study'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/study'

    it 'maillist is accessable', ->
        browser.get '/ml'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/ml'

    it 'profile is accessable', ->
        browser.get '/profile'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/profile'

    describe 'admin page', ->
        describe 'user', ->
            it 'list', ->
                browser.get '/admin/user'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/user'

            it 'detail', ->
                browser.get '/admin/user/1'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/user/1'

        describe 'year', ->
            it 'list', ->
                browser.get '/admin/year'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/year'

            describe 'each', ->
                it 'detail', ->
                    browser.get '/admin/year/1'
                    expect browser.getCurrentUrl()
                    .toEqual 'http://localhost:9000/admin/year/1'

                it 'edit', ->
                    browser.get '/admin/year/1/edit'
                    expect browser.getCurrentUrl()
                    .toEqual 'http://localhost:9000/admin/year/1/edit'

            it 'new', ->
                browser.get '/admin/year/new'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/year/new'

        describe 'subject', ->
            it 'list', ->
                browser.get '/admin/subject'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/subject'

            describe 'each', ->
                it 'detail', ->
                    browser.get '/admin/subject/1'
                    expect browser.getCurrentUrl()
                    .toEqual 'http://localhost:9000/admin/subject/1'

                it 'edit', ->
                    browser.get '/admin/subject/1/edit'
                    expect browser.getCurrentUrl()
                    .toEqual 'http://localhost:9000/admin/subject/1/edit'

            it 'new', ->
                browser.get '/admin/subject/new'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/subject/new'

        describe 'semester', ->
            it 'list', ->
                browser.get '/admin/semester'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/semester'

            describe 'each', ->
                it 'detail', ->
                    browser.get '/admin/semester/1'
                    expect browser.getCurrentUrl()
                    .toEqual 'http://localhost:9000/admin/semester/1'

                it 'edit', ->
                    browser.get '/admin/semester/1/edit'
                    expect browser.getCurrentUrl()
                    .toEqual 'http://localhost:9000/admin/semester/1/edit'

            it 'new', ->
                browser.get '/admin/semester/new'
                expect browser.getCurrentUrl()
                .toEqual 'http://localhost:9000/admin/semester/new'

    it 'logout', ->
        browser.get '/logout'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/logout'

        logoutButton = element By.partialButtonText 'Logout'
        logoutButton.click()

        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/'
