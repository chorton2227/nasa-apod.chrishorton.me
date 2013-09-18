//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require imagesloaded.min
//= require masonry.min
//= require lightbox.min
//= require infinite-scroll.min
//= require_tree .

$(function() {
  var $container = $('#image-container')
  $container.imagesLoaded(function(){
    $container.masonry({
      itemSelector: '.image-item'
    });
  });

  $container.infinitescroll({
    navSelector  : "div.pagination",
    nextSelector : "div.pagination a:first",
    itemSelector : "#image-container div.image-item",
  }, function (newElements) {
    // hide new items while they are loading
    var $newElems = $( newElements ).css({ opacity: 0 });
    // ensure that images load before adding to masonry layout
    $newElems.imagesLoaded(function(){
      // show elems now they're ready
      $newElems.animate({ opacity: 1 });
      $container.masonry( 'appended', $newElems, true );
    });
  });
});
