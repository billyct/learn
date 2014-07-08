Template.category_tag_label.helpers({
    category : ->
        return Categories.findOne({_id : String(@)})
})
