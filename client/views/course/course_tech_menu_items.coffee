Template.course_tech_menu_items.rendered = ->
    # sectionSort = new Sortable @find('#section_list'),
    #     handle : ".chapter_course"
    #     onUpdate: (e) ->
    #         console.log "xx"

    lectures_list = @findAll('ul')
    self = @

    _.each lectures_list, (lecture_list) ->
        new Sortable lecture_list,
            group : "lectures"
            onAdd : (e) ->
                sortOnAdd()
                $(e.item).remove()
            onUpdate : (e) ->
                sortOnUpdate(e.item)

    # sortOnAdd =>

    sortOnUpdate = (item)=>
        item = $(item)
        section = item.parents('.section-item').attr('id')
        lectures = item.parents('.lecture-list').find('.lecture-item')
        lecture_order = []
        _.each lectures, (lecture) ->
            lecture_order.push
                _id : $(lecture).attr('id')
        section_order =
            _id : section
            lectures : lecture_order

        Meteor.call "sortLecturesOnUpdate", section_order


    sortOnAdd = =>
        sections = @$('.section-item')
        section_order = []
        _.each sections, (section) ->
            section = $(section)
            lectures = section.find('.lecture-item')
            lecture_order = []
            _.each lectures, (lecture) ->
                lecture_order.push {
                    _id : $(lecture).attr('id')
                }
            section_order.push {
                _id : section.attr('id')
                lectures : lecture_order
            }

        Meteor.call "sortLecturesOnAdd", section_order
