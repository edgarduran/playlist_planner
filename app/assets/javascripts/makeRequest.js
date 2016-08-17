function requestSearch() {
  $('.request-search').on('click', function() {
    var query = $('#query').val();
    if (query === "") {
      alert("You must enter a name");
    } else {

      $.ajax({
        type: 'GET',
        url:  '/requests',
        data: { query: query},
        success: function(songs) {
          $('#request-search').openModal();
          $.each(songs.search_results, function(index, song) {
            $('#request-search').find('tbody').append(individualSong(song));
          });
          $('#query').val('');
        },
        error: function(xhr) {
          console.log(xhr.responseText);
        }
      });
    }
  });
}

function submitRequest() {
  $('.request-table').delegate('.add-song', 'click', function() {
    var songId = this.id;
    
    $.ajax({
      type: 'POST',
      url:  '/requests',
      data: { song_name: 'name',
              user_id: $userId,
              artists: 'seven',
              pl_id: $playlistId,
              user: $user,
              song_id: songId },
      success: function(req) {
        $('#request-search').closeModal();
        console.log('yes');
      },
      error: function(xhr) {
        console.log(xhr.responseText);
      }
    });
  });
}
