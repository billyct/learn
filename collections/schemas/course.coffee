Meteor.startup ->
    @CourseSchema = new SimpleSchema({
        name :
            type : String
            label : "#{t9n('course.name')}"
        index :
            type : String
            label : "#{t9n('course.index')}"
            unique: true
        description :
            type : String
            label : "#{t9n('course.description')}"
        status :
            type : Boolean
            label : "#{t9n('course.status')}"
        # price :
        #     type : Number
        #     label : '价格'
        # best_selling :
        #     type : Boolean
        #     label: '热卖'
        #     optional : true
        image :
            type : String
            label : "#{t9n('course.image')}"
            optional : true
        video :
            type : String #relate to uploads
            label : "#{t9n('course.video')}"
            optional : true
        categories :
            type : [String]
            label : "#{t9n('course.categories')}"
            minCount: 1
            # maxCount: 3

        author :
            type : String
            label : "#{t9n('course.author')}"
            autoValue : ->
                if this.isInsert
                    return Meteor.userId()
            denyUpdate : true

        created_at :
            type: Date
            autoValue : ->
                if this.isInsert
                    return new Date
                else if this.isUpsert
                    return {$setOnInsert : new Date}
                else
                    this.unset()
            denyUpdate: true
        updated_at :
            type : Date
            autoValue : ->
                new Date if this.isUpdate
            denyInsert : true
            optional : true

    })

    Courses.attachSchema @CourseSchema
