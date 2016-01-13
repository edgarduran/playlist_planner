require 'test_helper'

class LoggedInUserCanCrudPlaylistsTest < ActionDispatch::IntegrationTest

  test 'logged in user can create playlist' do
    visit '/'
    click_link "Login with Spotify"
    user  = User.first
    click_link "Create and View Playlists"
    click_link "Create New Playlist"
  end

  test 'logged in user can delete playlist' do
    skip
    visit '/'
    click_link "Login with Spotify"
    user  = User.first
    click_link "Create and View Playlists"  end

  test 'logged in user can upsdate playlist attributes' do
    skip
    visit '/'
    click_link "Login with Spotify"
    user  = User.first
    click_link "Create and View Playlists"
  end

end
