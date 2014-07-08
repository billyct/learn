if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'course_image', (id) ->
            return Uploads.find({ _id : id, type:'image'})

        Meteor.publish 'course_video', (id) ->
            return Uploads.find({ _id : id, type:'video'})
