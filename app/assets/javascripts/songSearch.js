function songSearch() {
  $('.search').on('click', function () {
    var query = $('#query').val();
    if (query === "") {
      alert("You must enter a name");
    }

    $.ajax({
      type: 'GET',
      url:  '/songs',
      data: { query: query},
      success: function() {
        console.log('sweet');
        $('#song-search').openModal();
      },
      error: function(xhr) {
        console.log('sheeeiit');
      }
    });
  });
}
