if Meteor.isServer
    Meteor.startup ->

        Meteor.publish 'uploads-by-courseId', (id) ->
            course = Courses.findOne({_id : id})
            uploads = []
            uploads.push course.video if course.video?
            uploads.push course.image if course.image?
            uploads_cursor = Uploads.find({_id : {$in : uploads}}) if uploads?
            return uploads_cursor

        Meteor.publish 'uploads-by-courseIndex', (index) ->
            course = Courses.findOne({index : index})
            uploads = []
            uploads.push course.video if course.video?
            uploads.push course.image if course.image?
            uploads_cursor = Uploads.find({_id : {$in : uploads}}) if uploads?
            return uploads_cursor


        Meteor.publish 'uploads-by-lectureId', (id) ->
            lecture = Lectures.findOne({_id : id})
            uploads = []
            uploads.push lecture.video if lecture.video?
            uploads.push lecture.audio if lecture.audio?
            uploads_cursor = Uploads.find({_id : {$in : uploads}}) if uploads?

            return uploads_cursor
