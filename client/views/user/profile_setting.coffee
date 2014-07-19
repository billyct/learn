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
            bootbox.alert "有错误，保存用户信息失败！" if err?
            bootbox.alert "保存成功！" if result?
