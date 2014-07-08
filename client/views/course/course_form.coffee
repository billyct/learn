Template.course_form.helpers({
    cateogriesOptions : ->
        categories = Categories.find({}, {sort:{order:1}}).fetch()
        return _.map categories, (category) ->
            return {
                value : category._id
                label : category.name
            }
    isCreate : ->
        Router.current().route.name is 'course_create'

    method : ->
        if Router.current().route.name is 'course_create'
            return {
                type : 'method'
                call : 'createCourse'
            }
        if Router.current().route.name is 'course_edit'
            return {
                type : 'update'
                call : null
            }
    categoriesReady : ->
        return true if Router.current().route.name is 'course_create'
        return @course?.categories

})



AutoForm.hooks
    courseForm :

        onSuccess: (operation, result, template) ->
            bootbox.alert "保存成功！" if result?
            if result? and operation is 'createCourse'
                Router.go("course_edit", {_id: result})
        onError: (operation, err, template) ->
            console.log "#{err.error}:#{err.reason}"
            return false;
