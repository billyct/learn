if Meteor.isServer
    Meteor.startup ->

        Meteor.publish 'courses', ->
            return Courses.find({}, {sort: {created_at:-1}})

        Meteor.publish 'latest_courses', ->
            if Courses.find().count() < 8
                return Courses.find({}, {limit:4, sort: {created_at: -1}})
            else
                return Courses.find({}, {limit:8, sort: {created_at: -1}})

        Meteor.publish 'courses_by_category_index', (index) ->
            category = Categories.findOne({index: index})
            if category?
                courses = Courses.find({categories : {$all : [category._id]}})
                return courses
            return null

        Meteor.publish 'course-detail', (id) ->

            cursors = []

            course_cursor = Courses.find({_id: id})
            course = Courses.findOne({_id: id})

            return cursors unless course?

            cursors.push course_cursor

            # 课程有关的文件内容
            uploads = []
            if course.video?
                uploads.push course.video

            if course.image?
                uploads.push course.image

            if uploads?
                uploads_cursor = Uploads.find({_id : {$in : uploads}})
                cursors.push uploads_cursor

            # 课程作者
            if course.author?
                users_cursor = Meteor.users.find({_id: course.author}, {fields: {profile : 1}})
                cursors.push users_cursor


            # 课程相关的章节和课时
            sections_cursor = Sections.find({course: course._id})
            sections = sections_cursor.fetch()

            return cursors unless sections?

            cursors.push sections_cursor

            lectures_cursor = Lectures.find({section: {$in: _.pluck(sections, '_id')}}, {fields: {video: 0, text: 0, audio: 0}})

            cursors.push lectures_cursor

            return cursors

        Meteor.publish 'author' , (id) ->
            Meteor.users.find({_id: id}, {fields: {profile : 1}})
