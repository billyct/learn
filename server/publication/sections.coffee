if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'sections', ->
            Sections.find({})

        Meteor.publish 'sections_by_course_index', (index) ->
            c = Courses.findOne({index: index})
            sections = Sections.find({course: c._id})
            return sections
