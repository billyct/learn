Template.lecture_form.helpers({
    sectionOptions : ->
        sections = Sections.find({}, {sort:{order:1}}).fetch()
        return _.map sections, (section) ->
            return {
                value : section._id
                label : section.title
            }
    isCreate : ->
        Router.current().route.name is 'lecture_create'
    typeOptions : ->
        return [
            {
                value : 'text',
                label : '文字'
            }
            {
                value : 'audio',
                label : '声音'
            }
            {
                value : 'video',
                label : '视频'
            }
        ]
    method : ->
        if Router.current().route.name is 'lecture_create'
            return {
                type : 'method'
                call : 'createLecture'
            }
        if Router.current().route.name is 'lecture_edit'
            return {
                type : 'method'
                call : 'updateLecture'
            }

    textReady : ->
        return true if Router.current().route.name is 'lecture_create'
        return @lecture?.text
    #为课程类型用
    textShow : ->
        if @lecture?.type is "text" or not @lecture?
            return true
        return false

    videoShow : ->
        if @lecture?.type is "video"
            return true
        return false
    audioShow : ->
        if @lecture?.type is "audio"
            return true
        return false

})


Template.lecture_form.rendered = ->


    self = @

    @$('select[name="type"]').on 'change', ->

        self.$('#audio-field').hide()
        self.$('#video-field').hide()

        if $(@).val() is 'text'
            return
        if $(@).val() is 'audio'
            self.$('#audio-field').show()
        if $(@).val() is 'video'
            self.$('#video-field').show()




# Template.lecture_form.events({
#     'click #submit': (e) ->
#         console.log AutoForm.getFormValues('lectureForm')
# })



AutoForm.hooks
    lectureForm :
        before:
            createLecture: (doc, template) ->
                doc.order = Lectures.find().count() + 1
                return doc

        onSuccess: (operation, result, template) ->
            bootbox.alert "保存成功！" if result?
            return
        onError: (operation, err, template) ->
            if err.error?
                bootbox.alert "#{err.error}:#{err.reason}"
            else
                bootbox.alert "#{err.message}"
            return false
