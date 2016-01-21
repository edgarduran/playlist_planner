require 'test_helper'

class UserCanCrudPlaylistsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  test "user can view playlists" do
      login_user
      user  = User.last

      click_link "Create and View Playlists"

      assert_equal playlists_path, current_path
      assert page.has_link?("View/Edit Details")
      assert page.has_content?("Your Playlists")
  end

  test "user can view a playlist" do
      login_user
      user  = User.last
      click_link "Create and View Playlists"
      assert_equal playlists_path, current_path

      click_link "View/Edit Details"
      assert page.has_content?("Tracks")
      assert page.has_link?("Rename Playlist")
  end

  test "user can navigate to add track" do
    login_user
    user  = User.last
    click_link "Create and View Playlists"
    assert_equal playlists_path, current_path

    click_link "View/Edit Details"

    fill_in "query", with: "Hey"
    click_button "Find Track"
    assert_equal songs_path, current_path
  end

  test "user can rename playlist" do
    login_user
    user  = User.last
    click_link "Create and View Playlists"
    assert_equal playlists_path, current_path
    click_link "View/Edit Details"

    click_on "Rename Playlist"


    fill_in "Name", with: "Test 2"
    click_on "Rename"
  end

end
