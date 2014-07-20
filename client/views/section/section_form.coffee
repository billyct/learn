Template.section_form.helpers({
    isCreate : ->
        Router.current().route.name is 'section_create'
    method : ->
        if Router.current().route.name is 'section_create'
            return {
                type : 'method'
                call : 'createSection'
            }
        if Router.current().route.name is 'section_edit'
            return {
                type : 'update'
                call : null
            }

})

AutoForm.hooks
    sectionForm :
        before:
            createSection: (doc, template) ->
                doc.order = Sections.find().count() + 1
                return doc

        onSuccess: (operation, result, template) ->
            bootbox.alert "#{t9n('success.save')}" if result?
            return
        onError: (operation, err, template) ->
            if err.error?
                bootbox.alert "#{err.error}:#{err.reason}"
            else
                bootbox.alert "#{err.message}"
            return false
