$(document).ready(function(){
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('.modal-trigger').leanModal({
      dismissible: true,
      opacity: .7,
      ready: function () {
        createPlaylist();
      }
    }
  );
});

function createPlaylist() {
  $('.create-btn').on('click', function(evt) {
    evt.preventDefault();
    var playlistName = $('#name').val();
    if (playlistName === "") {
      alert("Name can not be blank");
    }

  $.ajax({
      type: 'POST',
      url:  '/playlists',
      data: { name: playlistName},
      success: function() {
        showPlaylist(playlistName);
        $('#new-playlist').closeModal();
      },
      error: function(xhr) {
        console.log(xhr.responseText);
        $('#new-playlist').closeModal();
      }
    });
  });
}

function showPlaylist(playlistName) {
   $('.cards').prepend(newCard(playlistName));
}

function newCard(playlistName) {
  return $(
     "<div class='col s4'>"
      +"<div class='card blue-grey darken-1'>"
        +"<div class='card-content white-text'>"
          +"<span class='card-title black-text'><h3>" + playlistName + "</h3></span>"
          +"<p>There are currently 0 tracks in this playlist.</p>"
          +"<p>Navigate into playlist to see more options</p>"
        +"</div>"
        +"<div id='<%= newPlaylist.name %>' class='card-action'>"
          +"<a href='#!'>View/Edit Details</a>"
        +"</div>"
      +"</div>"
    +"</div>"
  )
}
