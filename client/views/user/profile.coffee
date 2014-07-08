Template.profile.helpers({
    current : ->
        return true if @user?._id is Meteor.userId()
        return false
})
