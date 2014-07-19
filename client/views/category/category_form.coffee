Template.category_form.helpers
    category : ->
        categoryId = Session.get('category')
        if categoryId?
            return Categories.findOne({_id : categoryId})
        return {}

    method : ->
        categoryId = Session.get('category')
        if categoryId
            return {
                type : 'update'
                call : null
            }
        return {
            type : 'method'
            call : 'createCategory'
        }



AutoForm.hooks
    categoryForm :
        before:
            createCategory: (doc, template) ->
                doc.order = Categories.find().count() + 1
                return doc

        onSuccess: (operation, result, template) ->
            bootbox.alert "保存成功！" if result?
            template.$('#category-form-modal').modal('hide')
            return
        onError: (operation, err, template) ->
            if err.error?
                bootbox.alert "#{err.error}:#{err.reason}"
            else
                bootbox.alert "#{err.message}"
            return false
