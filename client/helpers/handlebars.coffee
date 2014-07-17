UI.registerHelper 'fromNow', (date) ->
    return moment(date).fromNow()

UI.registerHelper '$eq', (a, b) ->
    return a is b
    
UI.registerHelper 'dotdotdot60', (str) ->
    if str.length > 60
        return str.substring(0, 60) + '...'
    return str
UI.registerHelper 'dotdotdot20', (str) ->
    if str.length > 20
        return str.substring(0, 20) + '...'
    return str

UI.registerHelper 'active', (routeName, options) ->
    current = Router.current()
    route = Router.helpers.pathFor(routeName, options)
    currentRoute = current.path.split('?')[0]
    if currentRoute is route
        return "active"
    return ""

UI.registerHelper 'range', (n, options) ->
    return (options.fn(i) for i in [1..n]).join("")

UI.registerHelper 'percent', (a, b, options) ->
    return a/b*100
