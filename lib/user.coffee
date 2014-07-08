isAdminById = (userId) ->
    user = Meteor.users.findOne(userId)
    return !!(user && isAdmin(User))

isAdmin = (user) ->
    user = if typeof user is 'undefined' then Meteor.user() else user
    return !!user && !!user.isAdmin 
