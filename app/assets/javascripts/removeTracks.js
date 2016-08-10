function removeTracks() {
  $('.delete-track').on('click', function(evt) {
    evt.preventDefault();
    var playlistId = $playlistId;
    var songId = this.id;
    var user = $user;
    var trackCard = $('.card[id="'+ songId + '"]');

    $.ajax({
      type: 'DELETE',
      url: '/songs/' + songId,
      data: { song_id: songId,
              pl_id: playlistId,
              user: user
            },
      success: function () {
        trackCard.remove()
      },
      error: function (xhr) {
        trackCard.remove()
      }
    });
  });
}
