if Meteor.isServer
    Meteor.startup ->

        Meteor.publish 'sections-by-courseId', (id) ->
            return Sections.find({course: id})

        Meteor.publish 'sections-by-courseIndex', (index) ->
            course = Courses.findOne({index: index})
            return Sections.find({course:course._id})
