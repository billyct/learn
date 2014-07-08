Router.configure
    layoutTemplate: 'layout_base'
    loadingTemplate: 'loading'
    notFoundTemplate: 'not_found'


# Router.onBeforeAction 'dataNotFound'


Router.onBeforeAction ->
    Session.set('url-target', if Router.current().path is '/sign-in' then '/' else Router.current().path)
