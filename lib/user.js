isAdminById = function (userId) {
    var user = Meteor.users.findOne(userId)
    return !!(user && isAdmin(user))
}

isAdmin = function (admin) {
    var user ;
    if (typeof(user) === 'undefined'){
        user = Meteor.user()
    } else {
        user = admin;
    }
    console.log(user);
    return !!user && !!user.isAdmin
}
