if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'studies-by-userId', (id) ->
            return Studies.find({user: id})
