Meteor.startup ->
    @UploadSchema = new SimpleSchema({
            name :
                type : String
                label : "#{t9n('upload.name')}"
            path :
                type : String
                label : "#{t9n('upload.path')}"

            persistentId:
                type: String
                label : "#{t9n('upload.persistentId')}"
                optional : true

            type :
                type : String
                allowedValues: ['image', 'video', 'audio'],
                label : "#{t9n('upload.type')}"

            server :
                type : String
                label : "#{t9n('upload.server')}"
                allowedValues: ['local', 'qiniu'],
                optional : true

            user :
                type : String
                label : "#{t9n('upload.user')}"
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
