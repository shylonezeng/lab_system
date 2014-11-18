function span_width () {
  return $('.span1').first().width();
}

function max_column_height() {
  var max = 0;
  $('.column').each(function() {
    var h = column_height($(this));
    max = h > max ? h : max;
  });
  return max;
}

function column_height(column) {
  var height = column.find('h4').height();

  // find the height of each header
  column.find('.header').each(function() {
    height += $(this).height();
    height += 34; // add margin between header boxes
  });

  // height of largest feature text
  var max = 0;
  column.find('.text').each(function() {
    var h = $(this).height();
    max = h > max ? h : max;
  });

  // combine them plus space for the h4
  return height + max;
}

function animate_open (element) {
  // open element if not already open
  if (!element.hasClass('opened')) {
    // step1: height of largest child
    var max = 0;
    element.find('.content').children().each(function () {
      var h = $(this).height();
      max = h > max ? h : max;
    });

    // step2: grow content div and make room for footer
    // header height() returns non-padded height, we need to add 12px on top and bottom plus space for a gap
    $('#menugrow').animate({height: $('#menugrow').height() + element.find('.header').height() + 24 + 12});
    element.find('.content').animate({height: max + 24 + 12});

    // step3: move the photo, text down
    // photo and text are now shifted 12px down already, so just move them the full header height + margin
    var header_height = element.find('.header').height();
    element.find('.photo, .text').animate({top: header_height + 24, opacity: 1}).css('overflow','visible');

    // step4: move text to the right
    var photo = element.find('.photo')
    if (photo.length > 0) {
      element.find('.text').animate({left: photo.width() + 12 });
    }

    // step5: fade in read more
    element.find('.read_more').fadeIn('slide');

    // step6: fade in close
    element.find('.closeFeature').fadeIn();

    // toggle
    element.addClass('opened');
  }
}

function animate_close (element) {
  // close element if not already closed
  if (element.hasClass('opened')) {

    // fade out the read more link
    element.find('.read_more').fadeOut('slide');

    // move text to the left
    if (element.find('.photo').length > 0) {
      element.find('.text').animate({left: 0});
    }

    // step6: fade out close
    element.find('.closeFeature').fadeOut();

    // move the photo, text up
    element.find('.photo, .text').animate({top: 0, opacity: .75});

    // shrink the content div and make room for footer
    element.find('.content').animate({height: 0});
    $('#menugrow').animate({height: $('#menugrow').height() - element.find('.header').height() - 36}).css('overflow','visible');

    // toggle
    element.removeClass('opened');
  }
}

function animate_column_open (column) {
  // open column if not already open
  if (!column.hasClass('column-opened')) {
    column.animate({ width: span_width() * 6 }, 500, function() {
      var el = $(this);

      el.addClass('span6')
        .removeClass('span3')
        .removeAttr('style')
        .addClass('column-opened');
    }).css('overflow','visible');
  }
}

function animate_column_close (column) {
  // close column if not already closed
  if (column.hasClass('column-opened')) {
    column.animate({ width: span_width() * 3 }, 500, function() {
      var el = $(this);

      el.addClass('span3')
        .removeClass('span6')
        .removeAttr('style')
        .removeClass('column-opened');
    }).css('overflow','visible');
  }
}

function animate (element) {
  if ($(window).width() < 768) {
    return;
  }

  // close everything that isn't myself
  $('.opened').each( function () {
    if ($(this)[0] !== element[0]) {
      animate_close($(this));
    }
  });

  // close other columns that don't have anything open
  var column = element.closest('.column');
  $('.column').each( function() {
    if ($(this)[0] !== column[0]) {
      animate_column_close($(this));
    }
  });

  // open/close what was clicked
  if (element.hasClass('opened')) {
    animate_close(element);
    animate_column_close(column);
  } else {
    animate_column_open(column);
    animate_open(element);
  }
}

$(document).ready(function() {
  // add closeFeature to features
  $('.feature').find('.text').prepend('<div class="closeFeature"></div>');
  $('.header').click(function() { animate( $(this).closest('.feature') ); });
  $('.closeFeature').click(function() { animate( $(this).closest('.feature'));});
  $('.closeFeature').hide();

  $('#menugrow').height(max_column_height() + $('footer').height());
  // hide the read more links
  if ($('body').width() > 768) {
    $('.read_more').hide();
  }

  // show read more when window is too small
  $(window).resize(function() {
    if ($('body').width() <= 768) {
      $('.read_more').fadeIn('slide');
    } else {
      $('.read_more').fadeOut('slide');
    }
  });

  // open guided tours for hash
  if (window.location.hash === "#guided-tours") {
    // when not on a phone
    if ($('body').width() <= 480) { return; }

    $('#windowTitleDialog').modal('show');
  }
});
