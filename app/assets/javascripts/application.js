// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require materialize-sprockets
//= require jquery_ujs
//= require turbolinks
//= require_tree .

$(document).ready(function(){
  // the "href" attribute of .modal-trigger must specify the modal ID that wants to be triggered
  $('.modal-trigger').leanModal({
      dismissible: true,
      opacity: 0.7,
      ready: function () {
        createPlaylist();
        renamePlaylist();
        emailink();
      }
    }
  );

  removeTracks();
  songSearch();
  approveRequest();
  denyRequest();
  requestSearch();
  submitRequest();
  addSong();
});
