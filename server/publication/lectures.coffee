if Meteor.isServer
    Meteor.startup ->

        Meteor.publish 'lecture-by-id', (id) ->
            return Lectures.find({_id : id})


        Meteor.publish 'lectures-by-courseId', (id) ->
            return Lectures.find({course: id}, {fields: {video: 0, text: 0, audio: 0}})

        Meteor.publish 'lectures-by-courseIndex', (index) ->
            course = Courses.findOne({index: index})
            return Lectures.find({course: course._id}, {fields: {video: 0, text: 0, audio: 0}})
