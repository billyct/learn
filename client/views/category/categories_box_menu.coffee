Template.categories_box_menu.helpers({
    categories : ->
        return Categories.find({}, {sort: {order: 1}})
})
