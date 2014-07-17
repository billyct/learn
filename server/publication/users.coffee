if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'author-by-courseIndex', (index) ->
            # 课程作者
            course = Courses.findOne({index : index})
            users_cursor = Meteor.users.find({_id: course.author}, {fields: {profile : 1}}) if course.author?
            return users_cursor

        Meteor.publish 'user', (userId) ->
            return Meteor.users.find({_id : userId})


        Meteor.publish 'profile', (id) ->

            user_cursor = Meteor.users.find({_id : id})

            courses_cursor = Courses.find({author: id}, {sort:{created_at:-1}})
            courses = courses_cursor.fetch()

            images = _.pluck(courses, 'image') if courses?

            uploads_cursor = Uploads.find({_id : {$in: images}}) if images?

            return [courses_cursor, uploads_cursor, user_cursor]
