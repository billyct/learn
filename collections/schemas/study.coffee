Meteor.startup ->
    @LectureStudySchema = new SimpleSchema({
        lecture :
            type : String
            label : "#{t9n('lecture')}"
        complete :
            type : Boolean
            label : "#{t9n('study.completed')}"
    })

    @StudySchema = new SimpleSchema({
        course:
            type : String
            label : "#{t9n('course')}"
        user :
            type : String
            label : "#{t9n('study.user')}"
        lectures :
            type : [@LectureStudySchema]
            label : "#{t9n('study.lectures')}"
            optional : true
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

    Studies.attachSchema @StudySchema
