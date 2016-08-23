function renamePlaylist() {
  $('.rename-btn').on('click', function(evt) {
    evt.preventDefault();
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
        $('#title').text(newName + 'PLP');
        $('#rename-playlist').closeModal();
      },
      error: function(xhr) {
        console.log(xhr.responseText);
      }
    });
  });
}
