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
          $('#song-search').openModal();
          $.each(songs.search_results, function(index, song) {
            $('#song-search').find('tbody').append(individualSong(song));
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
        var newSong = showSong(song);
        clickEventForTrack(newSong.find('.delete_track'));
        $('.pl-songs').append(newSong);
      },
      error: function(xhr) {
        console.log(xhr.responseText);
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
