Template.category_tag.helpers({
    category : ->
        return Categories.findOne({_id : String(@)})
})
