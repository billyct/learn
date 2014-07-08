Meteor.startup ->
    @SectionSchema = new SimpleSchema({
        title :
            type : String
            label : '课程章节名称'

        order :
            type : Number
            label : '章节排序'

        course :
            type : String
            label : '属于哪个课程'
            
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


    Sections.attachSchema @SectionSchema
