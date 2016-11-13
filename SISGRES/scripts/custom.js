// Jquery with no conflict
jQuery(document).ready(function ($) {

    $('#to-top').click(function () {
        $.scrollTo({ top: '0px', left: '0px' }, 300);
    });

   $(".selected").parent().attr('class', 'selectedItem');

    $("ul.tabs").tabs("div.panes > div", { effect: 'fade' });

    $(".accordion").accordion();

    $('#FooterMenu li').hover(function () {
        // over
        $(this).children('a').stop().animate({ marginLeft: "5" }, "fast");
    }, function () {
        // out
        $(this).children('a').stop().animate({ marginLeft: "0" }, "fast");
    });

});





