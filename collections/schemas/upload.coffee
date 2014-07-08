Meteor.startup ->
    @UploadSchema = new SimpleSchema({
            name :
                type : String
                label : '文件名称'
            path :
                type : String
                label : '文件地址'
                
            persistentId:
                type: String
                label : '转码标记查看是否转码成功'
                optional : true

            type :
                type : String
                allowedValues: ['image', 'video', 'audio'],
                label : '文件类型'

            server :
                type : String
                label : '文件所属服务器'
                allowedValues: ['local', 'qiniu'],
                optional : true

            user :
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

    Uploads.attachSchema @UploadSchema
