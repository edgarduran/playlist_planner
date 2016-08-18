function removeTracks() {
  $('.delete-track').each(clickEventForTrack);
}

function clickEventForTrack(track) {
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
      },
      error: function (xhr) {
        trackCard.remove();
      }
    });
  });
}
