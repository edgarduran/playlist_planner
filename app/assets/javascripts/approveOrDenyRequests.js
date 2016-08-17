function approveRequest() {
  $('.pending-requests').delegate('.approve-request', 'click', function () {
    var $requestId = this.closest('tr').id;
    var that = this;

    $.ajax({
      type: 'PATCH',
      url:  '/requests/' + $requestId,
      data: { status: 'approved',
              id: $requestId
            },
      success: function(song) {
        addSongToSpotify(that.id, that);
      },
      error: function(xhr) {
        console.log(xhr.responseText);
      }
    });
  });
}

function addSongToSpotify(songId, tableRow) {
  $.ajax({
    type: 'POST',
    url:  '/songs',
    data: { pl_id: $playlistId,
            user: $user,
            song_id: songId },
    success: function(song) {
      tableRow.closest('tr').remove();
      $('.pl-songs').append(showSong(song));
    },
    error: function(xhr) {
      console.log(xhr.responseText);
    }
  });
}

function denyRequest() {
  $('.pending-requests').delegate('.decline-request', 'click', function () {
    var $requestId = this.closest('tr').id;
    var that = this;

    $.ajax({
      type: 'PATCH',
      url:  '/requests/' + $requestId,
      data: { status: 'denied',
              id: $requestId
            },
      success: function() {
        that.closest('tr').remove();
      },
      error: function(xhr) {
        console.log(xhr.responseText);
      }
    });
  });
}
