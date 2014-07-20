Meteor.startup ->
    @SectionSchema = new SimpleSchema({
        title :
            type : String
            label : "#{t9n('section.title')}"

        order :
            type : Number
            label : "#{t9n('section.order')}"

        course :
            type : String
            label : "#{t9n('section.course')}"

        author :
            type : String
            label : "#{t9n('section.author')}"
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
