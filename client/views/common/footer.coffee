Template.footer.rendered = ->
    $(window).scroll ->
        if $(this).scrollTop() isnt 0
            $('#toTop').fadeIn()
        else
            $('#toTop').fadeOut()

    $('#toTop').click ->
        $('body,html').animate {scrollTop:0},500

    if window.innerWidth < 770
        $("button.forward, button.backword").click ->
            $("html, body").animate({ scrollTop: 115 }, "slow")
            return false
    if window.innerWidth < 500
        $("button.forward, button.backword").click ->
            $("html, body").animate({ scrollTop: 245 }, "slow")
            return false
    if window.innerWidth < 340
        $("button.forward, button.backword").click ->
            $("html, body").animate({ scrollTop: 280 }, "slow")
            return false
