$(function() {
  // SEE http://www.netmagazine.com/tutorials/create-fluid-width-videos

  var
    // Find all Vimeo videos
    $allVideos = $("iframe[src^='http://player.vimeo.com'],iframe[src^='https://player.vimeo.com']");

  // Figure out and save aspect ratio for each video
  $allVideos.each(function() {
    // store aspect ratio
    $(this).data('aspectRatio', $(this).height() / $(this).width());
    // remove original height
    $(this).removeAttr('height');
    // full-width
    $(this).attr('width', '100%');
  });

  // When the window is resized
  $(window).resize(function() {

    // resize height according to their own aspect ratio
    $allVideos.each(function() {
      var $el = $(this);
      $el.height($el.width() * $el.data('aspectRatio'));
    });

    // Kick off one resize to fix all videos on page load
  }).resize();
});
