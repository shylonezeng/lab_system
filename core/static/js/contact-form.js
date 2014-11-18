// on send, remove all errorlists
$('.contact-form').on('ajax:beforeSend', function(e, xhr, settings) {
  $(e.currentTarget).find('ul.errorlist').remove();
});

$('.contact-form').on('ajax:success', function(e, data) {
  $(e.currentTarget).find('p.messages').html(data.message);
});

$('.contact-form').on('ajax:error', function(e, xhr, status, error) {
  var errors = JSON.parse(xhr.responseText)
    , target = $(e.currentTarget);

  // blur everything so our shim fills in the placeholders again
  $('.contact-form :text, .contact-form textarea').trigger('blur');

  $.each(errors, function(field_name, errors) {
    var input_field, error_container, wrapped_errors;
    input_field = $(target.find('[name='+field_name+']'))
    error_container = $("<ul class='errorlist'/>")
    
    wrapped_errors = $.map(errors, function(error, idx) {
      var wrapped_error = '<li>'+error+'</li>';

      return wrapped_error;
    });

    error_container.append(wrapped_errors.join());
    error_container.prependTo(input_field.parent());

  });
  
  $(e.currentTarget).find('p.messages').html("There was a problem with the contact form.");
});
