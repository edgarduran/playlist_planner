require 'test_helper'

class LoggedInUserCanViewPlaylistsPageTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  test 'logged in user can navigate to playlist index' do
    VCR.use_cassette('get_playlist') do
      login_user
      click_link "Create and View Playlists"

      assert current_path, playlists_path
      assert page.has_content?("Playlists")
      assert page.has_link?("Create New Playlist")
    end
  end

  test 'logged in user can view all playlists' do
    VCR.use_cassette('get_playlist') do
      login_user
      click_link "Create and View Playlists"

      assert_equal playlists_path, current_path
      assert page.has_link?("View/Edit Details")
      assert page.has_content?("Your Playlists")
    end
  end

  test "user can view selected playlist" do
    VCR.user_cassette('get_playlist') do
      login_user
      click_link "Create and View Playlists"

      assert_equal playlists_path, current_path

      within(".row") do
        assert page.has_content?("Your Playlists")
        assert page.has_css?(".card-action")
      end
    end
  end

end
