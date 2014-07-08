marked.setOptions({
    highlight: (code, lang) ->
        type = if Prism.languages[lang]? then Prism.languages[lang] else Prism.languages.markup
        return Prism.highlight(code, type)
        # return hljs.highlightAuto(code).value
    langPrefix: 'language-'
})







Template.lecture_detail.lecture_text = ->
    if @lecture?.text?
        return marked(@lecture.text)


Template.lecture_detail.events({
    'click #mark-as-complete': (e, tpl) ->
        Meteor.call "studyLectureComplete", tpl.data.lecture
})
