require 'test_helper'

class LoggedInUserCanCrudPlaylistsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  test 'logged in user can create playlist' do
    skip
    visit '/'
    click_link "Login with Spotify"

    user  = User.first
    click_link "Create and View Playlists"
    save_and_open_page
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
