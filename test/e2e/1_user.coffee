describe 'User', ->
    it 'sign in as user and redirect to home', ->
        browser.get '/login'
        expect browser.getTitle()
        .toEqual '北医ネット - ログイン'

        email = element By.model 'credencials.email'
        email.sendKeys 'guest@ec.hokudai.ac.jp'
        password = element By.model 'credencials.password'
        password.sendKeys 'guest'

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

    it 'admin is not accessable', ->
        browser.get '/admin'
        # webStrage keeps token, so that AuthChecker will call api when page is loaded
        browser.waitForAngular()
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/'


    it 'logout', ->
        browser.get '/logout'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/logout'

        logoutButton = element By.partialButtonText 'Logout'
        logoutButton.click()


        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/'

