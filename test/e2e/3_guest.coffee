describe 'Guest', ->
    beforeEach ->
        browser.ignoreSynchronization = true
    afterEach ->
        browser.ignoreSynchronization = false

    it 'home', ->
        browser.get '/'
        expect browser.getTitle()
        .toEqual '北医ネット'

        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/'

    it 'study is not accessable', ->
        browser.get '/study'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/login'

    it 'maillist is not accessable', ->
        browser.get '/ml'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/login'

    it 'profile is not accessable', ->
        browser.get '/profile'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/login'

    it 'admin is not accessable', ->
        browser.get '/admin'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/'

    it 'logout', ->
        browser.get '/logout'
        expect browser.getCurrentUrl()
        .toEqual 'http://localhost:9000/logout'
