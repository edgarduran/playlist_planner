function createPlaylist() {
  $('.create-btn').on('click', function(evt) {
    evt.preventDefault();
    var playlistName = $('#name').val();

    if (playlistName === "") {
      alert("Name can not be blank");
    } else {

      $.ajax({
        type: 'POST',
        url:  '/playlists',
        data: { name: playlistName},
        success: function(newList) {
          $('#name').val('');
          showPlaylist(playlistName, newList);
          $('#new-playlist').closeModal();
        },
        error: function(xhr) {
          console.log(xhr.responseText);
        }
      });
    }
  });
}

function showPlaylist(playlistName, newList) {
   $('.cards').prepend(newCard(playlistName, newList));
}

function newCard(playlistName, newList) {
  return $(
     "<div class='col s4'>"
      +"<div class='card blue-grey darken-1 pl-card'>"
        +"<div class='card-content white-text'>"
          +"<span class='card-title black-text'><h3 class='card-top'>" + playlistName + " PLP</h3></span>"
          +"<p class='bottom'>There are currently 0 tracks in this playlist."
          +"Navigate into playlist to see more options.</p>"
        +"</div>"
        +"<div id='<%= newPlaylist.name %>' class='card-action'>"
          +"<a href='/playlists/%23%3CRSpotify::Playlist:0x007fc7caa2e448%3E?pl_id=" + newList.id
          +"&pl_name=" + newList.name + "&user=" + newList.owner.id + "&user_id=" + $userId
          +"'>View/Edit Details</a>"
        +"</div>"
      +"</div>"
    +"</div>"
  )
}