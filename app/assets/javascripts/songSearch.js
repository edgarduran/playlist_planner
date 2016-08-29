function songSearch() {
  $('.search').on('click', function() {
    var query = $('#query').val();

    if (query === "") {
      alert("You must enter a name");
    } else {

      $.ajax({
        type: 'GET',
        url:  '/songs',
        data: { query: query},
        success: function(songs) {
          $('#song-search').openModal({
            complete: function() { $('.song-table tr').remove(); }
          });
          $.each(songs.search_results, function(index, song) {
            $('#song-search').find('tbody').append(individualSong(song));
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

function addSong() {
  $('.song-table').delegate('.add-song', 'click', function() {
    var $songId = this.id;

    $.ajax({
      type: 'POST',
      url:  '/songs',
      data: { pl_id: $playlistId,
              user: $user,
              song_id: $songId },
      success: function(song) {
        $('#song-search').closeModal();
        $('.song-table tr').remove();
        var newSong = showSong(song);
        $('.pl-songs').append(newSong);
        clickEventForTrack(newSong.closest('.delete-track'));
        Materialize.toast('Track successfully added to your playlist', 5000);
      },
      error: function(xhr) {
        console.log(xhr.responseText);
        Materialize.toast('Oops! Your song was not added. Try again later', 5000);
      }
    });
  });
}

function showSong(song) {
  return $(
    "<div class='col s6'>"
    +"<div id='" + song[0].id + "' class='card blue-grey darken-1 track-card'>"
    +"<div class='card-content small-card white-text center'>"
    +"<span class='card-title track-title'>" + song[0].name + "</span>"
    +"<p class='track-artist'>" + song[0].artists[0].name + "</p>"
    +"</div>"
    +"<div class='card-action medium-action center'>"
    +"<button id='" + song[0].id + "' class='delete-track btn small red' name='delete'>Delete Track</button>"
    +"</div>"
    +"</div>"
    +"</div>"
  );
}

function individualSong(song) {
  return $(
    "<tr>"
    +"<td class='white-text'>" + song.name.substring(0, 45) + "</td>"
    +"<td class='white-text'>" + song.artists + "</td>"
    +"<td><button id='" + song.song_id + "' class='add-song btn medium lime darken-2' name='direct-add-song'>Add</button></td>"
    +"</tr>"
  );
}
