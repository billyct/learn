Template.profile.helpers({
    current : ->
        return true if @user?._id is Meteor.userId()
        return false
})


Template.profile.events
    'click a#button-remove-course': (e, tpl) ->
        t = e.currentTarget
        id = $(t).data('cid')

        bootbox.confirm "删除课程将删除该与课程相关的数据！确定删除？", (result) ->
            if result
                Meteor.call "removeCourse", id, (err, result) ->
                    bootbox.alert "#{err.error}:#{err.reason}" if err?
                    bootbox.alert "删除成功" if result?




# Template.profile.rendered = ->
#     $('a[data-toggle=tooltip]').tooltip()
