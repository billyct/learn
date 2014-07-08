Meteor.startup ->
    @CourseSchema = new SimpleSchema({
        name :
            type : String
            label : '课程名称'
        index :
            type : String
            label : '课程别名'
            unique: true
        description :
            type : String
            label : '课程描述'
        status :
            type : Boolean
            label : '课程发布状态'
        price :
            type : Number
            label : '价格'
        best_selling :
            type : Boolean
            label: '热卖'
            optional : true
        image :
            type : String
            label : '课程图片'
            optional : true
        video :
            type : String #relate to uploads
            label : '课程视频'
            optional : true
        categories :
            type : [String]
            label : '课程类别'
            minCount: 1
            maxCount: 3

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

    Courses.attachSchema @CourseSchema
