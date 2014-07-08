Meteor.startup ->
    @LectureStudySchema = new SimpleSchema({
        lecture :
            type : String
            label : "课时"
        complete :
            type : Boolean
            label : "是否已经完成了该课时"
    })

    @StudySchema = new SimpleSchema({
        course:
            type : String
            label : "课程"
        user :
            type : String
            label : "学习该课程的用户"
        lectures :
            type : [@LectureStudySchema]
            label : "课程学习记录"
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
