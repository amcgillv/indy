// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require jquery.ui.all
//= require ckeditor/init
//= require_tree .

$(function() {
    $('.admin-article-cover .author').draggable();
    $("#article_hero_caption").keyup(function () {
      var value = $(this).val();
      $(".author").html(value);
  }).keyup();
    $('.edit_article').submit(function() {
        var left = parseFloat($('.author').css('left'))
        var top = parseFloat($('.author').css('top'))
        var toppercent = top/280*100
        var leftpercent = left/700*100
        $('#article_hero_x').val(leftpercent)
        $('#article_hero_y').val(toppercent)
    })

    $('.zoom').zoom();

    $('.up-arrow').click(function() {
        $("html, body").animate({ scrollTop: 0 }, 600);
    });
    $('.notice, .alert').delay(1400).fadeOut(600);

    $(window).scroll(function(e) {
        if (window.pageYOffset > 200) {
            $('body').addClass('scrolled');
        } else {
            $('body').removeClass('scrolled');
        }
    });

    // hamburger button
    $("#ham").click(function(e) {
        $('body').toggleClass('noscroll');
        $(".overlay").toggleClass("full-page-nav");
    });

    $(".equis").click(function(e) {
        //closing the overlay
        $(".overlay").toggleClass("full-page-nav");
        $('body').toggleClass('noscroll');
    });
});