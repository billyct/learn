Meteor.startup ->
    @LectureSchema = new SimpleSchema({
        title :
            type : String
            label : '课时名称'

        order :
            type : Number
            label : '课时排序'
            optional : true
        video :
            type : String
            label : '课时视频'
            optional : true
        text :
            type : String
            label : '课时文字内容'
        audio :
            type : String
            label : '课时录音'
            optional: true
        type :
            type : String
            label : '课时类型'
            allowedValues: ['text', 'video', 'audio']
        section :
            type : String
            label : '课时章节'
        course :
            type : String
            label : '所属课程'
        time :
            type : String
            label : '课时时长'
        author :
            type : String
            label : '课程作者'
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
