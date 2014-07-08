# 好吧这个select2组件的使用真的非常的脏，但是无论如何它可以用
Template.afSelect_select2.rendered = ->
    $(@find('select')).select2()


# Template.afSelect_app.loaded = ->
#     if @items?
#         tems = _.filter(@items, (item)-> return item.selected is true)
#         $('select').select2('destroy')
#         $('select').val(_.pluck(tems, 'value')).select2()
#         return true
#     return false
