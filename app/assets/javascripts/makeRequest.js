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
          $('#request-search').openModal({
            complete: function() { $('.request-table tr').remove(); }
          });
          $.each(songs.search_results, function(index, song) {
            $('#request-search').find('tbody').append(individualResult(song));
          });
          $('#query').val('');
        },
        error: function(xhr) {
          console.log(xhr.responseText);
          Materialize.toast('Sorry! Could not find your songs', 5000);
        }
      });
    }
  });
}

function submitRequest() {
  $('.request-table').delegate('.add-request', 'click', function(evt) {
    evt.preventDefault();
    var songId = this.id;
    var songName = $(this).parents().find('#song-name').text();
    var artists = $(this).parents().find('#song-artists').text();

    $.ajax({
      type: 'POST',
      url:  '/requests',
      data: { song_name: songName,
              user_id: $userId,
              artists: artists,
              pl_id: $playlistId,
              user: $user,
              song_id: songId },
      success: function(req) {
        $('#request-search').closeModal();
        $('.request-table tr').remove();
         Materialize.toast('Your request has been submitted for approval', 4000);
      },
      error: function(xhr) {
        console.log(xhr.responseText);
        Materialize.toast('Sorry! Your song was not added. Please try again later', 5000);
      }
    });
  });
}

function individualResult(song) {
  return $(
    "<tr>"
    +"<td id='song-name' class='white-text'>" + song.name.substring(0, 45) + "</td>"
    +"<td id='song-artists' class='white-text'>" + song.artists + "</td>"
    +"<td><button id='" + song.song_id + "' class='add-request btn medium lime darken-2' name='direct-add-song'>Add</button></td>"
    +"</tr>"
  );
}
