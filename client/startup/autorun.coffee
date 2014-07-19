Meteor.startup ->
    Deps.autorun ->

        Meteor.subscribe 'course-count'
        Meteor.subscribe 'categories', ->
            categories = Categories.find({}).fetch()
            for category in categories
                Meteor.subscribe 'course-count-by-category', category._id

        if Meteor.user()
            Meteor.subscribe 'studies-by-userId', Meteor.userId()
