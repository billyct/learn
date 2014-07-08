Template.nav.rendered = ->

    jQuery('ul.sf-menu').superfish();

    new UISearch( document.getElementById( 'sb-search' ) )

    $('#mobnav-btn').click ->
        $('.sf-menu').slideToggle(400)
    $('.mobnav-subarrow').click ->
        $(this).parent().toggleClass("xpopdrop")

    return

Template.nav.helpers({
    categories : ->
        return Categories.find({}, {sort: {order: 1}})
})
