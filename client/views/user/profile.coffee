Template.profile.helpers({
    current : ->
        return true if @user?._id is Meteor.userId()
        return false
})


Template.profile.events
    'click a#button-remove-course': (e, tpl) ->
        t = e.currentTarget
        id = $(t).data('cid')

        bootbox.confirm "#{t9n('rusure.deleteCourse')}", (result) ->
            if result
                Meteor.call "removeCourse", id, (err, result) ->
                    bootbox.alert "#{err.error}:#{err.reason}" if err?
                    bootbox.alert "#{t9n('success.delete')}" if result?




# Template.profile.rendered = ->
#     $('a[data-toggle=tooltip]').tooltip()
