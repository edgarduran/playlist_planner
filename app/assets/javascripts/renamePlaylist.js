function renamePlaylist() {
  $('.rename-btn').on('click', function(evt) {
    evt.preventDefault();
    var that = $(this);
    that.off('click');

    var newName = $('#name').val();
    if (newName === "") {
      alert("Name can not be blank");
    }

    $.ajax({
      type: 'PATCH',
      url: '/playlists/' + $playlistId,
      data: { pl_id: $playlistId,
              user: $user,
              name: newName,
            },
      success: function() {
        $('#title').text(newName + ' PLP');
        $('#rename-playlist').closeModal();
        $('#name').val('');
        Materialize.toast('Playlist name changed to ' + newName, 5000);
      },
      error: function(xhr) {
        console.log(xhr.responseText);
        $('#rename-playlist').closeModal();
        $('#name').val('');
        Materialize.toast('Oops! Somthing went wrong. Please try again', 5000);
      }
    });
  });
}
