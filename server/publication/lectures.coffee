if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'lectures', ->
            Lectures.find({})

        Meteor.publish 'lectures_by_course_index', (index) ->
            c = Courses.findOne({index: index})
            sections = _.pluck Sections.find({course: c._id}).fetch(), '_id'
            return Lectures.find({section : {$in : sections}})

        Meteor.publish 'lecture_detail', (_id) ->
            return Lectures.findOne({_id : _id})


        
