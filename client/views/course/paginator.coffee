Template.paginator.helpers({

    pagination : ->

        total = parseInt(@) unless isNaN(parseInt(@))

        current = Router.current()

        params = current.params

        url = current.path.split('?')[0]

        per_page = if params.limit? then parseInt params.limit else AppSetting.page_limit
        current_page = if params.page? then parseInt params.page else 1

        last_page = if total > per_page then Math.ceil(total/per_page) else 1


        pages = []
        for i in [1..last_page]
            active = if i is current_page then "active" else ""
            pages.push {
                act : active
                num : i
            }


        if current_page is 1
            pre_page = 1
            pre_page_disabled = "disabled"
        else
            pre_page = current_page - 1
            pre_page_disabled = ""

        if current_page is last_page
            next_page = last_page
            next_page_disabled = "disabled"
        else
            next_page = current_page + 1
            next_page_disabled = ""

        return {
            url : url
            per_page : per_page
            current_page : current_page
            pages : pages
            pre_page : pre_page
            pre_page_disabled : pre_page_disabled
            next_page : next_page
            next_page_disabled : next_page_disabled
        }

})
