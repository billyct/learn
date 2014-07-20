# for epic editor
Template.afTextarea_epic.rendered = ->
    opts = {
      container: @find('div'),
      textarea: @find('textarea'),
      basePath: '/css/epic/',
      clientSideStorage: false,
      localStorageName: 'epiceditor',
      useNativeFullscreen: true,
      parser: marked,
      file: {
        name: 'epiceditor',
        defaultContent: '',
        autoSave: 100
      },
      theme: {
        base: 'base/epiceditor.css',
        preview: 'preview/github.css',
        editor: 'editor/epic-dark.css'
      },
      button: {
        preview: true,
        fullscreen: true,
        bar: "auto"
      },
      focusOnLoad: false,
      shortcut: {
        modifier: 18,
        fullscreen: 70,
        preview: 80
      },
      string: {
        togglePreview: "#{t9n('preview')}",
        toggleEdit: "#{t9n('edit')}",
        toggleFullscreen: "#{t9n('fullscreen')}"
      },
      autogrow: false
    }

    @editor = new EpicEditor(opts)
    @editor.load()


# for bootstrap markdown js
Template.afTextarea_markdown.rendered = ->
    @$('textarea').markdown({
        autofocus : false
        savable : false
        language : AppSetting.language
    })


# for pen js
Template.afTextarea_pen.rendered = ->
    @._editor.rebuild() if @._editor?
    unless @._editor?
        options = {
            editor: @find('#editor')
            class: 'pen'
            debug: false
            list: [
                'blockquote', 'h3', 'p', 'pre', 'insertorderedlist', 'insertunorderedlist',
                'indent', 'outdent', 'bold', 'italic', 'underline', 'createlink'
            ]
            textarea: '<textarea name="content"></textarea>'
            stay: false
        }

        @._editor = new Pen(options)

Template.afTextarea_pen.events({
    'click #hinted': (e) ->
        e.preventDefault()
        hinted = $(e.currentTarget)
        editor = $(e.currentTarget).prev('#editor')
        if editor.hasClass('hinted')
            editor.removeClass('hinted')
            hinted.removeClass('active')
        else
            editor.addClass('hinted')
            hinted.addClass('active')
})

Template.afTextarea_pen.destroyed = ->
    @._editor.destroy()
