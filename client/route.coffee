root =
    views:
        root: require './view/root'

base = [
    url: '/login'
    data:
        title: 'ログイン'
        rule:
            level: 0b001
            next: '/'
    views:
        content: require './view/login'
,
    url: '/signup'
    data:
        title: 'ユーザー登録申請'
        rule:
            level: 0b001
            next: '/'
    views:
        content: require './view/signup'
,
    url: '/help'
    views:
        content: require './view/help'
,
    url: '/reset_password'
    views:
        content: require './view/reset_password'
,
    url: '/credit'
    data:
        rule:
            level: 0b110
            next: '/login'
    views:
        content: require './view/credit'
]


admin = [
    url: '/'
    data:
        title: '管理'
    views:
        admin_main: require './view/admin/top'
,
    url: '/user'
    data:
        title: 'ユーザー管理'
    subs: [
        url: '/'
        views:
            admin_main: require './view/admin/user/list'
    ,
        url: '/:id'
        views:
            admin_main: require './view/admin/user/show'
        subs: [
            url: '/'
            data:
                mode: 'detail'
        ,
            url: '/json'
            data:
                mode: 'json'
        ,
            url: '/edit'
            data:
                mode: 'edit'
            views:
                admin_edit: require './view/admin/user/edit'
        ,
            url: '/delete'
            data:
                mode: 'delete'
        ]
    ]
,
    url: '/class_year'
    data:
        title: '学年管理'
    subs: [
        url: '/'
        views:
            admin_main: require './view/admin/class_year/list'
    ,
        url: '/new'
        views:
            admin_main: require './view/admin/class_year/edit'
    ,
        url: '/:id'
        views:
            admin_main: require './view/admin/class_year/show'
        subs: [
            url: '/'
            data:
                mode: 'detail'
        ,
            url: '/json'
            data:
                mode: 'json'
        ,
            url: '/edit'
            data:
                mode: 'edit'
            views:
                admin_edit: require './view/admin/class_year/edit'
        ,
            url: '/delete'
            data:
                mode: 'delete'
        ]
    ]
,
    url: '/subject'
    data:
        title: '教科管理'
    subs: [
        url: '/'
        views:
            admin_main: require './view/admin/subject/list'
    ,
        url: '/new'
        views:
            admin_main: require './view/admin/subject/edit'
    ,
        url: '/:id'
        views:
            admin_main: require './view/admin/subject/show'
        subs: [
            url: '/'
            data:
                mode: 'detail'
        ,
            url: '/json'
            data:
                mode: 'json'
        ,
            url: '/edit'
            data:
                mode: 'edit'
            views:
                admin_edit: require './view/admin/subject/edit'
        ,
            url: '/delete'
            data:
                mode: 'delete'
        ]
    ]
,
    url: '/semester'
    data:
        title: '教科管理'
    subs: [
        url: '/'
        views:
            admin_main: require './view/admin/semester/list'
    ,
    #     url: '/new'
    #     views:
    #         admin_main: require './view/admin/semester/edit'
    # ,
        url: '/:id'
        views:
            admin_main: require './view/admin/semester/show'
        subs: [
            url: '/'
            data:
                mode: 'detail'
        ,
            url: '/json'
            data:
                mode: 'json'
    #     ,
    #         url: '/edit'
    #         data:
    #             mode: 'edit'
    #         views:
    #             admin_edit: require './view/admin/semester/edit'
    #     ,
    #         url: '/delete'
    #         data:
    #             mode: 'delete'
        ]
    ]
,
    url: '/news'
    data:
        title: 'お知らせ管理'
    subs: [
        url: '/'
        views:
            admin_main: require './view/admin/news/list'
    ,
        url: '/new'
        views:
            admin_main: require './view/admin/news/edit'
    ,
        url: '/:id'
        views:
            admin_main: require './view/admin/news/show'
        subs: [
            url: '/'
            data:
                mode: 'detail'
        ,
            url: '/json'
            data:
                mode: 'json'
        ,
            url: '/edit'
            data:
                mode: 'edit'
            views:
                admin_edit: require './view/admin/news/edit'
        ,
            url: '/delete'
            data:
                mode: 'delete'
        ]

    ]
]

member = [
    url: '/'
    views:
        content: require './view/home'
,
    url: '/profile'
    views:
        content: require './view/profile'
,
    url: '/study'
    views:
        content: require './view/study'
,
    url: '/logout'
    data:
        title: 'ログアウト'
    views:
        content: require './view/logout'
,
    url: '/admin'
    data:
        rule:
            level: 0b100
            next: '/'
            message: 'アクセス権がありません'
    views:
        content: require './view/admin'
        sidebar_content: require './view/admin/sidebar'
    subs: admin
]

root.subs = base

root.subs.push
    data:
        rule:
            level: 0b110
            next: '/login'
    subs: member

root.subs.push
    url: '*'
    data:
        title: '404'
    views:
        content: require './view/404'


module.exports = root
