function removeTracks() {
  // $('.delete-track').each(clickEventForTrack);
  $('.delete-track').on('click', function(evt) {
    evt.preventDefault();
    Materialize.toast('Delete not working at this time. Remove manually via spoitify ', 5000);
  });
}

function clickEventForTrack() {

  // $(this).on('click', function(evt) {
  //   evt.preventDefault();
  //   var that = $(this);
  //   that.off('click');
  //
  //   var $songId = this.id;
  //   var trackCard = $('.card[id="'+ $songId + '"]');
  //
  //   $.ajax({
  //     type: 'DELETE',
  //     url: '/songs/' + $songId,
  //     data: { song_id: $songId,
  //       pl_id: $playlistId,
  //       user: $user
  //     },
  //     success: function () {
  //       trackCard.remove();
  //       Materialize.toast('Song removed from playlist', 2500);
  //     },
  //     error: function (xhr) {
  //       console.log(xhr.responseText);
  //       Materialize.toast('Delete at work', 5000);
  //     }
  //   });
  // });
}
