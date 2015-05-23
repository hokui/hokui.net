'use strict'

angular.module moduleConfig

.config (EnvProvider)->
    login =
        credencials:
            email: 'admin@eis.hokudai.ac.jp'
            password:  'admin'
        keepLogin: true

    signup =
        user:
            email: 'abe@eis.hokudai.ac.jp'
            email_mobile: 'abe@example.com'
            family_name: '阿部'
            given_name: '高和'
            handle_name: 'あべさん'
            password: 'yaranaika'

    EnvProvider
    .setSeed 'login', login
    .setSeed 'signup', signup
