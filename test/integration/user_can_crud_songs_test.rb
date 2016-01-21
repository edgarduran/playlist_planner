require 'test_helper'

class UserCanCrudSongsTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  test 'logged in user can navigate to playlist index' do
      login_user
      click_link "Create and View Playlists"

      assert current_path, playlists_path
      assert page.has_content?("Playlists")
      assert page.has_link?("View/Edit Details")

      click_link "View/Edit Details"

      assert current_path, songs_path

      fill_in "Query", with: "Boom"
      click_button "Find Track"

      assert page.has_content?("Search Results:")
      assert page.has_button?("Add to Playlist")
      # within("#song_3j0oJtPonSYt9f5jHVLb91") do
      #   click_button("Add to Playlist")
      # end
  end

  test 'logged in user can approve and decline songs' do
    login_user
    click_link "Create and View Playlists"
    click_link "View/Edit Details"

    assert page.has_content?("pending requests")
    assert page.has_link?("Remove From Playlist")
    # within('#song_5Q0Nhxo0l2bP3pNjpGJwV1') do
    #   click_on("Remove From Playlist")
    # end
  end
end
