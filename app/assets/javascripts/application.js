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

    if ($('.article-cover').length > 0) {
        $(window).scroll(function () {
            if ($(window).scrollTop() < window.innerHeight/2) {
                var opacity = 1 - $(window).scrollTop()/window.innerHeight*2
                $('.article-cover').css('opacity', opacity)
            }
        });
    }

    $('.up-arrow').click(function() {
        $("html, body").animate({ scrollTop: 0 }, 600);
    });
    $('.notice, .alert').delay(1400).fadeOut(600);

    // mobile nav. u know how we swag up & down wit the user like swishhhh....
    // cribbed: https://medium.com/@mariusc23/hide-header-on-scroll-down-show-on-scroll-up-67bbaae9a78c#.fzbtpcv3b
    var didScroll = false;
    var lastScrollTop = 0;
    var delta = 1;
    var navbarHeight = $('nav').outerHeight();
    $(window).scroll(function(e) {
        didScroll = true;
    });
    function hasScrolled() {
        var st = $(window).scrollTop();
        if (Math.abs(lastScrollTop - st) <= delta) return;
        if (st > lastScrollTop && st > navbarHeight)
            $('nav').removeClass('nav-down').addClass('nav-up');
        else {
            if(st + $(window).height() < $(document).height())
                $('nav').removeClass('nav-up').addClass('nav-down');
        }
        lastScrollTop = st;
    }
    setInterval(function() {
        if (didScroll) {
            hasScrolled();
            didScroll = false;
        }
    }, 250);

    // hamburger button
    $(".ting, nav, #mobile-nav").addClass("ham-inactive");
    $("#ham").click(function(e) {
        $("body, .ting, nav, #mobile-nav").toggleClass("ham-active").toggleClass("ham-inactive");
        $("#ham").toggleClass("x");
    });
});