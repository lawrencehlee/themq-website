$(function() {
    loadOwlCarousel();
});

function loadOwlCarousel() {
    $('.owl-carousel').owlCarousel({
        singleItem: true,
        mouseDrag: false,
        autoPlay: 8000
    });
}
