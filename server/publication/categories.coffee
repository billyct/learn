if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'categories', ->
            Categories.find({})
