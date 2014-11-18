//Add the slider images here.
var slider;
var images = [
  "/static/img/slide-000.png",
  "/static/img/slide-001.jpg",
  "/static/img/slide-000.png",
  "/static/img/slide-002.jpg",
  "/static/img/slide-000.png",
  "/static/img/slide-003.jpg",
  "/static/img/slide-000.png",
  "/static/img/slide-004.jpg"
];

//Add references to the content overlay for each slider image
var content = [
  "/static/homepage-slides/slide-00.html",
  "/static/homepage-slides/slide-01.html",
  "/static/homepage-slides/slide-02.html",
  "/static/homepage-slides/slide-03.html",
  "/static/homepage-slides/slide-04.html",
  "/static/homepage-slides/slide-05.html",
  "/static/homepage-slides/slide-06.html",
  "/static/homepage-slides/slide-07.html"
];


var index = 0;
var transitionSpeed = 500;
var imageIntervals = 5000;
var flipSpeed = 300;
var startIntervals;
var intervalSetTime;
var contentOpen = false;

$(document).ready(function(){
  slider = $('#content_slider').bxSlider({
    mode: 'fade',
    controls: false,
    pause: imageIntervals
  });

  $('#go-prev').click(function(){
    slider.goToPreviousSlide();
    return false;
  });

  $('#go-next').click(function(){
    slider.goToNextSlide();
    return false;
  });

  for (i=0;i<=images.length - 1;i++){
    $('#thumb-container').append('<a href="javascript:goToContent('+ i +')"><img src="'+ images[i] +'?size=thumb" alt="Image '+ i +'" /></a>');
  }

  for (i=1;i<=content.length;i++){
    $("#content-" + i).load(content[i - 1]);
  };

  $(function() {
    $.preload(images, {
      init: function(loaded, total) {
	$("#indicator").html("<img src='img/load.gif' />");
      },

      loaded_all: function(loaded, total) {
	$('#indicator').fadeOut('slow', function() {
	  $('#left-side').fadeIn('slow');
	  $('#thumb-container').fadeIn('slow');
	  $.backstretch(images[index], {speed: transitionSpeed});
	});
      }
    });
  });
});

function goToContent(slideNum){
  clearInterval(intervalSetTime);
  index = slideNum;
  $.backstretch(images[index]);
  slider.goToSlide(slideNum);
};

function showContent(){
  $('.content-bg').fadeIn('slow');

};
function closeContent(){
  $('.content-bg').fadeOut(3000);

};
