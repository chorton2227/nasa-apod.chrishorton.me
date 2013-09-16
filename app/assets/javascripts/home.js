if (window.addEventListener) { // Mozilla, Netscape, Firefox
    window.addEventListener('load', arrangeImagesWithMasonry, false);
} else if (window.attachEvent) { // IE
    window.attachEvent('onload', arrangeImagesWithMasonry);
}

function arrangeImagesWithMasonry(event) {
	var img_container;
	img_container = $('#image-container');
	img_container.masonry({
	  itemSelector: '.image-item'
	});
}
