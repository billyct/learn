Meteor.startup ->
    @CategorySchema = new SimpleSchema({
        name :
            type : String
            label : "分类名称"
            max : 200
        index :
            type : String
            label : '分类别名'
            unique: true
        order :
            type : Number
            label : '分类排序'
            min : 0
        courses :
            type : [String]
            label : '分类课程'
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

    Categories.attachSchema @CategorySchema
