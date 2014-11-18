$(function() {
  var nav_block_icons = $('#nav-block-icons li');

  // close callouts if accordion link is clicked
  $('section, #nav-accordion').click(function() {
    nav_block_icons.removeClass("icon-active");
    $('.nav-block-callout').each(function() { $(this).hide(); });
  });


  // show/hide tooltips for icons as appropriate
  nav_block_icons.click(function (event) {
    // toggle what was clicked
    var id = this.id.match(/icon-(.+)/)[1];
    var div = $('#nav-block-'+id);
    // strip class off all icons
    nav_block_icons.removeClass("icon-active");
    // add it to the open one
    $(this).addClass("icon-active");
    div.toggle();

    // hide everything else
    $('.nav-block-callout').each(function() {
      if ($(this)[0] !== div[0]) {
        console.log($(this));
        $(this).hide();
      }
    });
  });

  // swapout navs when scrolling only on big screens

  $(window).scroll(function() {
    if ($(window).width() >= 980) {
      if ($(window).scrollTop() > 300) {
        if ($('.navbar-fixed-top').hasClass('visible')) {
          // do nothing
        } else {
            $('.navbar-fixed-top').hide().removeClass('hidden-desktop').fadeIn().addClass('visible');
        }
      } else {
        $('.navbar-fixed-top').fadeOut(400, function() {
          $(this).addClass('hidden-desktop').removeClass('visible');
        });
      }
    }
  });
});

$(function() {
  $('body').on('touchstart.dropdown', '.dropdown-menu', function(e) { e.stopPropagation(); });
});
