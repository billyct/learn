Meteor.startup ->
    @LectureSchema = new SimpleSchema({
        title :
            type : String
            label : "#{t9n('lecture.title')}"

        order :
            type : Number
            label : "#{t9n('lecture.order')}"
            optional : true
        video :
            type : String
            label : "#{t9n('lecture.video')}"
            optional : true
        text :
            type : String
            label : "#{t9n('lecture.text')}"
        audio :
            type : String
            label : "#{t9n('lecture.audio')}"
            optional: true
        type :
            type : String
            label : "#{t9n('lecture.type')}"
            allowedValues: ['text', 'video', 'audio']
        section :
            type : String
            label : "#{t9n('lecture.section')}"
        course :
            type : String
            label : "#{t9n('lecture.course')}"
        time :
            type : String
            label : "#{t9n('lecture.time')}"
        author :
            type : String
            label : "#{t9n('lecture.author')}"
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

    Lectures.attachSchema @LectureSchema
