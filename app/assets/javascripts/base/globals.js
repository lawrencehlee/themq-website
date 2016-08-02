$(function() {
    addNavbarItemClasses();
});

function addNavbarItemClasses() {
    $navbarMapper = $('.navbar-mapper');
    if ($navbarMapper.length !== 0) {
        // Find navbar item with the correct text and underline it via
        // current-page class
        $navbarItem =
            $('#navbar-nav ul li a:contains("' + $navbarMapper.text() + '")');
        $navbarItem.addClass('current-page');

        // Set the navbar item to always show, as it's the current page
        $navbarItemLi = $navbarItem.parent();
        $navbarItemLi.addClass('priority-primary');
        $navbarItemLi.removeClass('priority-secondary');
    }
}
