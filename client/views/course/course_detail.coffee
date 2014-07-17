Template.course_detail.helpers
    complete_count : ->
        if @study?.lectures?
            completed = _.filter @study.lectures, (l) ->
                return l.complete is true
            return completed.length
        return 0

    lectureId_to_learn : ->

        lectureId = null

        if @course?

            study = Studies.findOne({course: @course._id, user: Meteor.userId()})
            lectures = Lectures.find({}, {sort: {order:1}}).fetch()

            if study?
                lectures_to_learn = _.filter study.lectures, (lecture)->
                    return lecture.complete is false
                lectures_to_learn = _.pluck lectures_to_learn, 'lecture'

                for lecture in lectures
                    if _.contains(lectures_to_learn, lecture._id)
                        lectureId = lecture._id
                        break
            else
                if lectures.length > 0
                    lectureId = lectures[0]._id

        return lectureId
