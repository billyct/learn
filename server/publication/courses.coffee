if Meteor.isServer
    Meteor.startup ->

        Meteor.publish 'courses', ->
            if arguments[0]? then page = parseInt(arguments[0]) else page = 1
            if arguments[1]? then limit = parseInt(arguments[1]) else limit = AppSetting.page_limit

            skip = limit*(page-1)

            courses_cursor = Courses.find({status: true}, {sort: {created_at : -1}, limit: limit, skip : skip})
            courses = courses_cursor.fetch()

            uploads_cursor = Uploads.find({_id : {$in : _.pluck(courses, 'image')}})

            return [courses_cursor, uploads_cursor]

        Meteor.publish 'courses-latest', ->
            if Courses.find().count() < 8
                latest_courses_cursor =  Courses.find({status: true}, {limit:4, sort: {created_at: -1}})
            else
                latest_courses_cursor = Courses.find({status: true}, {limit:8, sort: {created_at: -1}})

            latest_courses = latest_courses_cursor.fetch()

            uploads_cursor = Uploads.find({_id : {$in : _.pluck(latest_courses, 'image')}})

            return [latest_courses_cursor, uploads_cursor]

        Meteor.publish 'courses-by-category', (index) ->
            category = Categories.findOne({index: index})
            return [] unless category?

            if arguments[1]? then page = parseInt(arguments[1]) else page = 1
            if arguments[2]? then limit = parseInt(arguments[2]) else limit = AppSetting.page_limit

            skip = limit*(page-1)

            courses_cursor = Courses.find({categories : {$all : [category._id]}, status: true}, {sort: {created_at : -1}, limit:limit, skip:skip})
            courses = courses_cursor.fetch()

            uploads_cursor = Uploads.find({_id : {$in : _.pluck(courses, 'image')}})

            return [courses_cursor, uploads_cursor]


        Meteor.publish 'course-by-index', (index) ->
            return Courses.find({index: index})



        Meteor.publish 'course-by-id', (id) ->
            return Courses.find({_id: id})


        Meteor.publish 'course-detail-by-lectureId', (id) ->
            lecture = Lectures.findOne({_id : id})
            section = Sections.findOne({_id : lecture?.section})
            course = Courses.findOne({_id : section.course})

            course_cursor = Courses.find({_id : section.course})

            sections_cursor = Sections.find({course: course._id})
            sections = sections_cursor.fetch()

            return [course_cursor] unless sections?

            lectures_cursor = Lectures.find({section: {$in: _.pluck(sections, '_id')}}, {fields: {video: 0, text: 0, audio: 0}})

            return [sections_cursor, course_cursor, lectures_cursor]
