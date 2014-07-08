Meteor.startup ->
    Template.courses_list_item.rendered = ->
        Holder.run()
