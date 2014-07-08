Meteor.publishCounter = (params) ->
    count = 0
    init = true
    id = params.id
    pub = params.handle
    collection = params.collection
    filter = params.filter
    options = params.options
    name = params.name

    handle = collection.find(filter, options).observeChanges
        added : =>
            count++
            pub.changed(name, id, {count: count}) unless init
        removed : =>
            count--
            pub.changed(name, id, {count: count}) unless init

    init = false
    pub.added name, id, {count: count}

    pub.ready()

    pub.onStop -> handle.stop()

if Meteor.isServer
    Meteor.startup ->
        Meteor.publish 'course-count', ->
            Meteor.publishCounter
                id : 'course-count'
                handle : this
                name : 'counts'
                collection : Courses
                filter : {}
                options : {}

        Meteor.publish 'course-count-by-category',  (_id)->
            Meteor.publishCounter
                id : _id
                handle : this
                name : 'counts'
                collection : Courses
                filter : {categories: {$all : [_id]}}
                options : {}
