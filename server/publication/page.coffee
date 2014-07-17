# if Meteor.isServer
#     Meteor.startup ->
#
#         Meteor.publish 'page-home', ->
#             if Courses.find().count() < 8
#                 latest_courses_cursor =  Courses.find({status: true}, {limit:4, sort: {created_at: -1}})
#             else
#                 latest_courses_cursor = Courses.find({status: true}, {limit:8, sort: {created_at: -1}})
#
#             latest_courses = latest_courses_cursor.fetch()
#
#             uploads_cursor = Uploads.find({_id : {$in : _.pluck(latest_courses, 'image')}})
#
#             return [latest_courses_cursor, uploads_cursor]
#
#         Meteor.publish 'page-courses', ->
#             if arguments[0]? then page = parseInt(arguments[0]) else page = 1
#             if arguments[1]? then limit = parseInt(arguments[1]) else limit = AppSetting.page_limit
#
#             skip = limit*(page-1)
#
#             courses_cursor = Courses.find({status: true}, {sort: {created_at : -1}, limit: limit, skip : skip})
#             courses = courses_cursor.fetch()
#
#             uploads_cursor = Uploads.find({_id : {$in : _.pluck(courses, 'image')}})
#
#             return [courses_cursor, uploads_cursor]
#
#
#         Meteor.publish 'page-courses-by-category', (index) ->
#             category = Categories.findOne({index: index})
#             return [] unless category?
#
#             if arguments[1]? then page = parseInt(arguments[1]) else page = 1
#             if arguments[2]? then limit = parseInt(arguments[2]) else limit = AppSetting.page_limit
#
#             skip = limit*(page-1)
#
#             courses_cursor = Courses.find({categories : {$all : [category._id]}, status: true}, {sort: {created_at : -1}, limit:limit, skip:skip})
#             courses = courses_cursor.fetch()
#
#             uploads_cursor = Uploads.find({_id : {$in : _.pluck(courses, 'image')}})
#
#             return [courses_cursor, uploads_cursor]
#
#         Meteor.publish 'page-course-detail', (index) ->
#
#             cursors = []
#
#             course_cursor = Courses.find({index: index})
#             course = Courses.findOne({index: index})
#
#             return cursors unless course?
#
#             cursors.push course_cursor
#
#             # 课程有关的文件内容
#             uploads = []
#             if course.video?
#                 uploads.push course.video
#
#             if course.image?
#                 uploads.push course.image
#
#             if uploads?
#                 uploads_cursor = Uploads.find({_id : {$in : uploads}})
#                 cursors.push uploads_cursor
#
#             # 课程作者
#             if course.author?
#                 users_cursor = Meteor.users.find({_id: course.author}, {fields: {profile : 1}})
#                 cursors.push users_cursor
#
#
#             # 课程相关的章节和课时
#             sections_cursor = Sections.find({course: course._id})
#             sections = sections_cursor.fetch()
#
#             return cursors unless sections?
#
#             cursors.push sections_cursor
#
#             lectures_cursor = Lectures.find({section: {$in: _.pluck(sections, '_id')}}, {fields: {video: 0, text: 0, audio: 0}})
#
#             cursors.push lectures_cursor
#
#             return cursors
#
#         Meteor.publish 'page-lecture-detail', (id)->
#             lecture_cursor = Lectures.find({_id : id})
#
#             lecture = Lectures.findOne({_id : id})
#
#
#             uploads = []
#             uploads.push lecture.video if lecture.video?
#             uploads.push lecture.audio if lecture.audio?
#             uploads_cursor = Uploads.find({_id : {$in : uploads}}) if uploads?
#
#
#             return [lecture_cursor, uploads_cursor]
#
#         Meteor.publish 'page-lecture-detail-box', (id) ->
#
#             lecture = Lectures.findOne({_id : id})
#             section = Sections.findOne({_id : lecture?.section})
#             course = Courses.findOne({_id : section.course})
#
#             course_cursor = Courses.find({_id : section.course})
#
#             sections_cursor = Sections.find({course: course._id})
#             sections = sections_cursor.fetch()
#
#             return [course_cursor] unless sections?
#
#             lectures_cursor = Lectures.find({section: {$in: _.pluck(sections, '_id')}}, {fields: {video: 0, text: 0, audio: 0}})
#
#             return [sections_cursor, course_cursor, lectures_cursor]
#
#         Meteor.publish 'page-profile', (id) ->
#
#             user_cursor = Meteor.users.find({_id : id})
#
#             courses_cursor = Courses.find({author: id}, {sort:{created_at:-1}})
#             courses = courses_cursor.fetch()
#
#             images = _.pluck(courses, 'image') if courses?
#
#             uploads_cursor = Uploads.find({_id : {$in: images}}) if images?
#
#             return [courses_cursor, uploads_cursor, user_cursor]
#
#         Meteor.publish 'course-edit-menu', (id) ->
#             cursors = []
#             course_cursor = Courses.find({_id: id})
#             course = Courses.findOne({_id: id})
#
#             return cursors unless course?
#
#             cursors.push course_cursor
#
#             sections_cursor = Sections.find({course: id})
#
#             sections = sections_cursor?.fetch()
#
#             return cursors unless sections?
#
#             cursors.push sections_cursor
#
#             lectures_cursor = Lectures.find({section: {$in: _.pluck(sections, '_id')}})
#
#             cursors.push lectures_cursor
#
#             return cursors
#
#         Meteor.publish 'course-study', (courseId, userId) ->
#             study_cursor = Studies.find({course: courseId, user: userId})
#
#             return study_cursor
