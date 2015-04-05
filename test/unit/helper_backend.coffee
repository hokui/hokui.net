'use strict'

window.mocks =
    admin_credencials:
        email: 'admin@eis.hokudai.ac.jp'
        password: 'admin'

    user_credencials:
        email: 'guest@eis.hokudai.ac.jp'
        password: 'guest'

    admin_user:
        activation_state: "active"
        admin: true
        approval_state: "approved"
        birthday: "1990-01-01"
        class_year_id: 1
        email: "admin@eis.hokudai.ac.jp"
        email_mobile: "admin@example.com"
        errors: {}
        family_name: "admin"
        full_name: "admin admin"
        given_name: "admin"
        handle_name: "admin"
        id: 1
        last_activity_at: null
        last_login_at: null
        last_login_from_ip_address: null
        last_logout_at: null

    user_user:
        activation_state: "active"
        admin: false
        approval_state: "approved"
        birthday: "1990-01-01"
        class_year_id: 1
        email: "guest@eis.hokudai.ac.jp"
        email_mobile: "guest@example.com"
        errors: {}
        family_name: "guest"
        full_name: "guest guest"
        given_name: "guest"
        handle_name: "guest"
        id: 2
        last_activity_at: null
        last_login_at: null
        last_login_from_ip_address: null
        last_logout_at: null

    admin_token: 'ThisIsTestTokenOfAdmin'
    user_token: 'ThisIsTestTokenOfUser'


window.mockupAPI = ($httpBackend)->
    $httpBackend
    .whenPOST '/api/session', mocks.admin_credencials
    .respond
        token: mocks.admin_token
        user: mocks.admin_user

    $httpBackend
    .whenPOST '/api/session', mocks.user_credencials
    .respond
        token: mocks.user_token
        user: mocks.user_user

    $httpBackend
    .whenPOST '/api/session'
    .respond 422, ''

    $httpBackend
    .whenDELETE '/api/session'
    .respond 200, ''

    $httpBackend
    .whenGET '/api/profile', (headers)->
        return headers['Access-Token'] is mocks.admin_token
    .respond 200, mocks.admin_user

    $httpBackend
    .whenGET '/api/profile', (headers)->
        return headers['Access-Token'] is mocks.user_token
    .respond 200, mocks.user_user

    $httpBackend
    .whenGET '/api/profile'
    .respond 401, ''


getLoginAsAdminProc = ($httpBackend, Auth)->
    ->
        $httpBackend.expectPOST '/api/session'
        Auth.login mocks.admin_credencials, false
        $httpBackend.flush()

getLoginAsUserProc = ($httpBackend, Auth)->
    ->
        $httpBackend.expectPOST '/api/session'
        Auth.login mocks.user_credencials, false
        $httpBackend.flush()
