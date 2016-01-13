require 'test_helper'

class LoggedInUserCanViewPlaylistsPageTest < ActionDispatch::IntegrationTest

  test 'logged in user can navigate to playlist index' do
    visit '/'
    click_link "Login with Spotify"
    user  = User.first
    assert current_path, landing_path(user)
    click_link "Create and View Playlists"
    assert current_path,  playlists_path
    assert page.has_content?("Playlists")
    assert page.has_link?("Create New Playlist")
  end

end
