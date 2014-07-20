Router.map ->

    metaDescription = "一个meteor炼制的在线教育网站"


    @route 'home',
        path: '/'
        template : 'home'
        waitOn : ->
            return [
                Meteor.subscribe 'courses-latest'
            ]
        data : ->
            return {
                latest_courses : Courses.find({}, {sort : {created_at : -1}}, {transform:null})
            }
        onAfterAction : ->
            SEO.set
                title: "#{t9n('home')}-learn"
                meta:
                  'description': metaDescription
                og:
                  'title': "#{t9n('home')}-learn"
                  'description': metaDescription


    @route 'courses',
        path : '/courses'
        waitOn : ->
            page = if @params.page? then parseInt @params.page else 1
            limit = if @params.limit? then parseInt @params.limit else AppSetting.page_limit

            return [
                Meteor.subscribe 'courses', page, limit
            ]
        data : ->
            return {
                courses : Courses.find({}, {sort : {created_at : -1}}, {transform:null})
                course_count : Counts.findOne('course-count')?.count
            }
        onAfterAction : ->
            SEO.set
                title: "#{t9n('course.list')}-learn"
                meta:
                  'description': metaDescription
                og:
                  'title': "#{t9n('course.list')}-learn"
                  'description': metaDescription

    @route 'courses_by_category',
        path : '/category/:index'
        template : 'courses'
        waitOn: ->
            page = if @params.page? then parseInt @params.page else 1
            limit = if @params.limit? then parseInt @params.limit else AppSetting.page_limit

            return [
                Meteor.subscribe 'courses-by-category', @params.index, page, limit
            ]
        data : ->
            return {
                courses : Courses.find({}, {sort : {created_at : -1}}, {transform:null})
                course_count : Categories.findOne({index: @params.index})?.course_count()
            }
        onAfterAction : ->
            category = Categories.findOne({index:@params.index})
            SEO.set
                title: "#{category?.name}-#{t9n('course.list')}-learn"
                meta:
                  'description': metaDescription
                og:
                  'title': "#{category?.name}-#{t9n('course.list')}-learn"
                  'description': metaDescription


    @route 'course_create',
        path : '/tech/courses'
        template : 'course_form'
        waitOn : ->
            return [
                Meteor.subscribe 'user', Meteor.userId()
            ]

        onBeforeAction : ->
            AccountsEntry.signInRequired(@)

        onAfterAction : ->
            SEO.set
                title: "#{t9n('course.create')}-learn"


    @route 'course_edit',
        path : '/tech/courses/:_id'
        template : 'course_form'
        waitOn : ->
            return [
                Meteor.subscribe 'course-by-id' , @params._id
                Meteor.subscribe 'sections-by-courseId', @params._id
                Meteor.subscribe 'lectures-by-courseId', @params._id
                Meteor.subscribe 'uploads-by-courseId', @params._id
            ]

        data : ->
            return {
                course : Courses.findOne({_id : @params._id})
            }
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)

            SEO.set
                title: "#{t9n('course.edit')}#{@data().course?.name}-learn"


    @route 'course_detail',
        path: '/courses/:index'

        waitOn : ->
            return [
                Meteor.subscribe 'course-by-index', @params.index
                Meteor.subscribe 'sections-by-courseIndex', @params.index
                Meteor.subscribe 'lectures-by-courseIndex', @params.index
                Meteor.subscribe 'uploads-by-courseIndex', @params.index
                Meteor.subscribe 'author-by-courseIndex', @params.index
            ]

        data : ->
            return {
                course : Courses.findOne({index : @params.index})
                study : if Meteor.userId()? then Studies.findOne() else {}
            }

        onAfterAction : ->
            if Meteor.user()? and @data().course?
                Meteor.call "studyCreate", @data().course._id

            SEO.set
                title: "#{@data().course?.name}-learn"
                meta:
                  'description': @data().course?.description
                og:
                  'title': "#{@data().course?.name}-learn"
                  'description': @data().course?.description


    @route 'section_create',
        path : '/tech/courses/:courseId/sections'
        template : 'section_form'
        waitOn : ->
            return [
                Meteor.subscribe 'course-by-id' , @params.courseId
                Meteor.subscribe 'sections-by-courseId', @params.courseId
                Meteor.subscribe 'lectures-by-courseId', @params.courseId
            ]
        data : ->
            return {
                course : Courses.findOne({_id: @params.courseId})
            }
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)

        onAfterAction : ->
            SEO.set
                title: "#{t9n('section.create')}-learn"

    @route 'section_edit',
        path : '/tech/courses/:courseId/sections/:_id'
        template : 'section_form'
        waitOn : ->
            return [
                Meteor.subscribe 'course-by-id' , @params.courseId
                Meteor.subscribe 'sections-by-courseId', @params.courseId
                Meteor.subscribe 'lectures-by-courseId', @params.courseId
            ]
        data: ->
            return {
                course : Courses.findOne({_id: @params.courseId})
                section : Sections.findOne({_id : @params._id})
            }
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)
        onAfterAction : ->
            SEO.set
                title: "#{t9n('section.edit')}#{@data().section?.title}-learn"

    @route 'lecture_create',
        path : '/tech/courses/:courseId/lectures'
        template : 'lecture_form'
        waitOn : ->
            return [
                Meteor.subscribe 'course-by-id' , @params.courseId
                Meteor.subscribe 'sections-by-courseId', @params.courseId
                Meteor.subscribe 'lectures-by-courseId', @params.courseId
            ]
        data: ->
            return {
                course : Courses.findOne({_id : @params.courseId})
            }
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)
        onAfterAction : ->
            SEO.set
                title: "#{t9n('lecture.create')}-learn"

    @route 'lecture_edit',
        path : '/tech/courses/:courseId/lectures/:_id'
        template : 'lecture_form'
        waitOn : ->
            return [
                Meteor.subscribe 'course-by-id' , @params.courseId
                Meteor.subscribe 'sections-by-courseId', @params.courseId
                Meteor.subscribe 'lectures-by-courseId', @params.courseId

                Meteor.subscribe 'lecture-by-id', @params._id
                Meteor.subscribe 'uploads-by-lectureId', @params._id
            ]
        data: ->
            return {
                course : Courses.findOne({_id : @params.courseId})
                lecture : Lectures.findOne({_id : @params._id})
            }
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)
        onAfterAction : ->
            SEO.set
                title: "#{t9n('lecture.edit')}#{@data().lecture?.title}-learn"


    @route 'lecture_detail',
        path : '/lectures/:_id'
        waitOn : ->
            return [
                Meteor.subscribe 'course-detail-by-lectureId' , @params._id

                Meteor.subscribe 'lecture-by-id', @params._id
                Meteor.subscribe 'uploads-by-lectureId', @params._id
            ]
        data : ->
            return {
                lecture : Lectures.findOne({_id : @params._id})
                course : Courses.findOne({})
            }

        onBeforeAction : ->
            AccountsEntry.signInRequired(@)

        onAfterAction : ->
            if Meteor.user()? and @data().lecture?
                Meteor.call "studyLectureCreate", @data().lecture

            SEO.set
                title: "#{@data().lecture?.title}-learn"
                meta:
                  'description': @data().course?.description
                og:
                  'title': "#{@data().lecture?.title}-learn"
                  'description': @data().course?.description


    @route 'profile_setting',
        path : '/profile/setting'
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)
        waitOn : ->
            return [
                Meteor.subscribe 'user', Meteor.userId()
            ]
        data : ->
            return {
                user : Meteor.users.findOne()
            }
        onAfterAction : ->
            SEO.set
                title: "#{@data().user?.profile.name}-#{t9n('profile.setting')}-learn"
                og:
                  'title': "#{@data().user?.profile.name}-#{t9n('profile.setting')}-learn"

    @route 'profile',
        path : '/profile/:_id?'
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)
        waitOn : ->

            return [
                if @params._id? then Meteor.subscribe 'profile', @params._id else Meteor.subscribe 'profile', Meteor.userId()
            ]
        data : ->
            return {
                user : if @params._id? then Meteor.users.findOne({_id : @params._id}) else Meteor.user()
                courses : Courses.find({}, {sort:{created_at:-1}}).fetch()
            }
        onAfterAction : ->
            SEO.set
                title: "#{@data().user?.profile.name}-#{t9n('profile.page')}-learn"
                og:
                  'title': "#{@data().user?.profile.name}-#{t9n('profile.page')}-learn"



    @route 'categories_management',
        path : '/management/categories'
        onBeforeAction : ->
            AccountsEntry.signInRequired(@)
        waitOn : ->
            return [
                Meteor.subscribe 'user', Meteor.userId()
            ]
        data : ->
            return {
                categories : Categories.find({}, {sort:{order: 1}}).fetch()
                user : Meteor.users.findOne()
            }
        onAfterAction : ->
            SEO.set
                title: "#{t9n('category.management')}-learn"
                og:
                  'title': "#{t9n('category.management')}-learn"
