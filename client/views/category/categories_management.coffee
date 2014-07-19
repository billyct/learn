# Template.categories_management.rendered = ->
#     $('a[data-toggle=tooltip]').tooltip()

Template.categories_management.events
    'click a#button-remove-category' : (e, tpl) ->
        t = e.currentTarget
        id = $(t).data('cid')

        bootbox.confirm "确定删除?", (result) ->
            if result
                Meteor.call "removeCategory", id, (err, result) ->
                    bootbox.alert "#{err.error}:#{err.reason}" if err?
                    bootbox.alert "删除成功" if result?
    'click a#button-edit-category' : (e, tpl) ->
        t = e.currentTarget
        id = $(t).data('cid')

        Session.set('category', id)

        $('#category-form-modal').modal()
    'click #button-create-category' : (e, tpl) ->

        Session.set('category', '')

        $('#category-form-modal').modal()
