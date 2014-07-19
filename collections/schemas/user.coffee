Meteor.startup ->
    @UserProfile = new SimpleSchema({
        name :
            type : String
            optional: true
        avatar :
            type : String
            optional : true
        github :
            type : String
            optional : true
    })
