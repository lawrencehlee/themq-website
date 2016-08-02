$(document).ready(function() {
    var $showNavMore;
    var $showNavMoreLink;
    setup();
});

function setup() {
    $showNavMore = $('#show-nav-more');
    $showNavMoreLink = $showNavMore.find('a');
    assignNavMoreHandlers()
}

function assignNavMoreHandlers() {
    $showNavMoreLink.on('click', toggleSecondaryPriority);
}

function toggleSecondaryPriority() {
    if ($('.priority-secondary').css('display') == 'none') {
        $('.priority-secondary').css('display', 'inline-block');
    }
    else {
        $('.priority-secondary').css('display', 'none');
    }
}
