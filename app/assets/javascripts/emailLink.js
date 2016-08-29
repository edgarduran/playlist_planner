function emailink() {
  $('.send-emails').on('click', function(evt) {
    evt.preventDefault();
    var that = $(this);
    that.off('click');

    if ($('.addresses').val() === '') {
      Materialize.toast('Cannot be blank', 2500, 'red');
    } else {
      var emails = $('.addresses').val();

      $.ajax({
      type: 'POST',
        url: '/mailers',
        data: { email: emails },
        success: function () {
          $('.addresses').val('');
          $('#email-link').closeModal();
          Materialize.toast('Email(s) sent!', 3500);
        },
        error: function (xhr) {
          console.log(xhr.responseText);
          $('.addresses').val('');
          Materialize.toast('Oops! Somthing went wrong. Please try again', 4000);
        }
      });
    }
  });
}
