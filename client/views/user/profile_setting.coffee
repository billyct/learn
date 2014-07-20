Template.profile_setting.events
    'click #button-save' : (e, tpl) ->
        e.preventDefault()

        display_name = tpl.$('input[name="name"]').val()
        introduce = tpl.$('textarea[name="introduce"]').val()

        doc =
            profile :
                name : display_name
                introduce : introduce

        set =
            "profile.name" : doc.profile.name,
            "profile.introduce" : doc.profile.introduce

        Meteor.users.update {_id: Meteor.userId()}, {$set:set}, (err, result) ->
            bootbox.alert "#{t9n('err.saveUser')}" if err?
            bootbox.alert "#{t9n('success.save')}" if result?
