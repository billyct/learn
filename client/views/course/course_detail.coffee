Template.course_detail.helpers
    complete_count : ->
        if @study?.lectures?
            completed = _.filter @study.lectures, (l) ->
                return l.complete is true
            return completed.length
        return 0
