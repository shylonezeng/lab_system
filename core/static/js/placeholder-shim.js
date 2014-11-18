// Credit Where Credit is Due
// http://www.cssnewbie.com/cross-browser-support-for-html5-placeholder-text-in-forms/

$(function() {
  var test = document.createElement('input')
    , text_selector = ":text,textarea"
    , supports_placeholder
    , active;
  if ('placeholder' in test) {
    supports_placeholder = true;
  }

  if (!supports_placeholder) {
    active = document.activeElement;
    $(text_selector).on('focus', function (e) {
        var thiz = $(e.currentTarget);
        if (thiz.attr('placeholder') !== '' && thiz.val() == thiz.attr('placeholder')) {
            thiz.val('').removeClass('hasPlaceholder');
        }
    });
    $(text_selector).on('blur', function (e) {
        var thiz = $(e.currentTarget);
        if (thiz.attr('placeholder') !== '' && (thiz.val() == '' || thiz.val() == thiz.attr('placeholder'))) {
            thiz.val(thiz.attr('placeholder')).addClass('hasPlaceholder');
        }
    });
    $(text_selector).blur();
    $(active).focus();
    $('form').submit(function () {
        $(this).find('.hasPlaceholder').each(function() { $(this).val(''); });
    }); 
  }
});
