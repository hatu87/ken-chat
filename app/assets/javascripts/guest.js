(function($){
  $(function(){

    $('.button-collapse').sideNav();
    $('.parallax').parallax();

    $('.modal-trigger').leanModal({
      dismissible: true,
      opacity: 0.3
    });
  }); // end of document ready
})(jQuery); // end of jQuery name space
