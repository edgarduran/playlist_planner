require 'test_helper'

class LoggedInUserCanViewPlaylistsPageTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
    login_user
  end

  test 'logged in user can navigate to playlist index' do
    click_link "Create and View Playlists"

    assert current_path,  playlists_path
    assert page.has_content?("Playlists")
    assert page.has_link?("Create New Playlist")
  end

  test 'logged in user can view all playlists' do
    click_link "Create and View Playlists"

    assert_equal playlists_path, current_path
    assert page.has_link?("View/Edit Details")
  end

  test "user can view selected playlist" do
    
  end

# test "user can create playlist" do
#   click_link "Generate a Playlist"
#
#   assert_equal new_playlist_path, current_path
#
#   fill_in "City, ST", with: "Denver, CO"
#   click_button "Generate Playlist"
#
#   assert page.has_content?("Denver, CO #{Time.now.strftime("%m/%d/%Y")}")
# end

end
