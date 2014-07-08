# if Meteor.isServer
#     Meteor.startup ->
#
#         uploads = [
#             {
#                 name : 'art image'
#                 path : '/uploads/default/art.jpg'
#                 type : 'image'
#                 server : 'local'
#             }
#             {
#                 name : 'business image'
#                 path : '/uploads/default/business.jpg'
#                 type : 'image'
#                 server : 'local'
#             }
#             {
#                 name : 'math image'
#                 path : '/uploads/default/math.jpg'
#                 type : 'image'
#                 server : 'local'
#             }
#             {
#                 name : 'poetry image'
#                 path : '/uploads/default/poetry.jpg'
#                 type : 'image'
#                 server : 'local'
#             }
#             {
#                 name : 'videogular video'
#                 path : '/uploads/default/videogular' #不加后缀名 本地的时候 不同类型不同后缀名 文件名相同
#                 type : 'video'
#                 server : 'local'
#             }
#         ]
#
#         uploads_result = new Array
#
#         videos_result = new Array
#
#
#         uploads_count = Uploads.find().count()
#         if uploads_count is 0
#             Uploads.remove({})
#             for upload in uploads
#                 if upload.type is 'image'
#                     Uploads.insert upload, (err, result) ->
#                         uploads_result.push result
#                 if upload.type is 'video'
#                     Uploads.insert upload, (err, result) ->
#                         videos_result.push result
#         else
#             ups = Uploads.find().fetch()
#             images = _.where(ups, {type: 'image'})
#             videos = _.where(ups, {type: 'video'})
#             uploads_result = _.pluck images, '_id'
#             videos_result = _.pluck videos, '_id'
#
#         categories = [
#             {
#                 name : '程序UI设计'
#                 index : 'ui-design'
#                 order : 1
#             }
#             {
#                 name : 'Web编程'
#                 index : 'web-develop'
#                 order : 2
#             }
#             {
#                 name : '移动开发'
#                 index : 'mobile-develop'
#                 order : 3
#             }
#             {
#                 name : '创客思维'
#                 index : 'maker-think'
#                 order : 4
#             }
#         ]
#
#
#         categories_result = new Array
#         category_count = Categories.find().count()
#         if category_count is 0
#             Categories.remove({})
#             for category in categories
#                 Categories.insert category, (err, result) ->
#                     categories_result.push result
#         else
#             categories_result = _.pluck Categories.find().fetch(), '_id'
#
#
#
#         courses = [
#             {
#                 name : 'HTML5编程基础'
#                 index : 'html5-program-basic'
#                 description : 'HTML5是用于取代1999年所制定的 HTML 4.01 和 XHTML 1.0 标准的 HTML 标准版本，现在仍处于发展阶段，但大部分浏览器已经支持某些 HTML5 技术。HTML 5有两大特点：首先，强化了 Web 网页的表现性能。其次，追加了本地数据库等 Web 应用的功能。广义论及HTML5时，实际指的是包括HTML、CSS和JavaScript在内的一套技术组合。它希望能够减少浏览器对于需要插件的丰富性网络应用服务（plug-in-based rich internet application，RIA)，如Adobe Flash、Microsoft Silverlight，与Oracle JavaFX的需求，并且提供更多能有效增强网络应用的标准集。'
#                 status : true
#                 price : 0
#                 image : uploads_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#                 categories : [categories_result[0]]
#             }
#             {
#                 name : 'test'
#                 index : 'test'
#                 description : 'test HTML 4.01 和 XHTML'
#                 status : true
#                 price : 0
#                 image : uploads_result[1]
#                 video : videos_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#                 categories : [categories_result[1]]
#             }
#             {
#                 name : 'Windows程序设计'
#                 index : 'windows-program-design'
#                 description : '1. 使用经典教材《Windows程序设计(第五版)》2. Windows SDK 编程教学（C 语言调用 API 实现）3. 配套课后作业，扩展阅读，知识点备忘'
#                 status : true
#                 price : 0
#                 author : Meteor.users.find().fetch()[1]['_id']
#                 image : uploads_result[2]
#                 categories : [categories_result[2]]
#             }
#             {
#                 name : 'Java语言-中级课程'
#                 index : 'java-language-middle-level'
#                 description : 'Java语言中级课程是Fenby针对广大编程爱好者推出的专业Java系列课程, 该课程可以让学习者从零基础入门直至完全掌握Java语言的所有知识点。并且通过多个实例让学习者可以在实践中充分领悟Java语言的真实用法及相关技巧。'
#                 status : true
#                 price : 0
#                 image : uploads_result[3]
#                 video : videos_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#                 categories : [categories_result[3]]
#             }
#
#         ]
#
#         courses_result = new Array
#         course_count = Courses.find().count()
#         if course_count is 0
#             Courses.remove({})
#             for c in courses
#                 Courses.insert c, (err, result) ->
#                     courses_result.push result
#         else
#             courses_result = _.pluck Courses.find().fetch(), '_id'
#
#         sections = [
#             {
#                 title : 'Welcome.'
#                 order : 1
#                 course : courses_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#             }
#             {
#                 title : 'Core'
#                 order : 2
#                 course : courses_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#             }
#             {
#                 title : 'Publish and subscribe'
#                 order : 3
#                 course : courses_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#             }
#             {
#                 title : 'Methods'
#                 order : 4
#                 course : courses_result[0]
#                 author : Meteor.users.find().fetch()[1]['_id']
#             }
#         ]
#
#         sections_result = new Array
#         section_count = Sections.find().count()
#
#         if section_count is 0
#
#             Sections.remove({})
#             for s in sections
#                 Sections.insert s, (err, result) ->
#                     sections_result.push result
#         else
#             sections_result = _.pluck Sections.find({}, {sort: {order : 1}}).fetch(), '_id'
#
#         lectures = [
#             {
#                 title : 'Quick start!'
#                 introduce : 'The following works on all supported platforms.
#
#                             Install Meteor:
#
#                             $ curl https://install.meteor.com | /bin/sh
#                             Create a project:
#
#                             $ meteor create myapp
#                             Run it locally:
#
#                             $ cd myapp
#                             $ meteor
#                             => Meteor server running on: http://localhost:3000/
#                             Unleash it on the world (on a free server we provide):
#
#                             $ meteor deploy myapp.meteor.com'
#                 order : 1
#                 video : ''
#                 audio : ''
#                 type : 'text'
#                 section : sections_result[0]
#                 time : '05:57'
#             }
#             {
#                 title : 'Seven Principles'
#                 introduce : 'Data on the Wire. Don\'t send HTML over the network. Send data and let the client decide how to render it.
# One Language. Write both the clients and the server parts of your interface in JavaScript.
# Database Everywhere. Use the same transparent API to access your database from the client or the server.
# Latency Compensation. On the client, use prefetching and model simulation to make it look like you have a zero-latency connection to the database.
# Full Stack Reactivity. Make realtime the default. All layers, from database to template, should make an event-driven interface available.
#
# Embrace the Ecosystem. Meteor is open source and integrates, rather than replaces, existing open source tools and frameworks.
#
# Simplicity Equals Productivity. The best way to make something seem simple is to have it actually be simple. Accomplish this through clean, classically beautiful APIs.
# '
#                 order : 2
#                 video : ''
#                 audio : ''
#                 type : 'text'
#                 section : sections_result[0]
#                 time : '02:37'
#             }
#             {
#                 title : 'Developer Resource'
#                 introduce : 'If anything in Meteor catches your interest, we hope you\'ll get involved with the project!
#
# STACK OVERFLOW
# The best place to ask (and answer!) technical questions is on Stack Overflow. Be sure to add the meteor tag to your question.
# MAILING LISTS
# We have two mailing lists for Meteor.  meteor-talk@googlegroups.com is for general questions, requests for help, and new project announcements. meteor-core@googlegroups.com is for coordinating changes to Meteor core packages and the build tools.
# GITHUB
# The core code is on GitHub. If you re able to write code or file issues, we\'d love to have your help. Please read Contributing to Meteor for how to get started.'
#                 order : 3
#                 video : ''
#                 audio : ''
#                 type : 'text'
#                 section : sections_result[0]
#                 time : '05:57'
#             }
#         ]
#
#         lecture_count = Lectures.find().count()
#         if lecture_count is 0
#             Lectures.remove({})
#             for l in lectures
#                 Lectures.insert l
