function removeTracks() {
  $('.delete-track').each(clickEventForTrack);
}

function clickEventForTrack() {
  $(this).on('click', function(evt) {
    evt.preventDefault();
    var $songId = this.id;
    var trackCard = $('.card[id="'+ $songId + '"]');

    $.ajax({
      type: 'DELETE',
      url: '/songs/' + $songId,
      data: { song_id: $songId,
        pl_id: $playlistId,
        user: $user
      },
      success: function () {
        trackCard.remove();
        Materialize.toast('Song removed from playlist', 2500);
      },
      error: function (xhr) {
        console.log(xhr.responseText);
        Materialize.toast('Oops! Somthing went wrong. Please try again', 5000);
      }
    });
  });
}
