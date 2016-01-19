require 'test_helper'

class UserLogsInWithSpotifyTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  test "user logs in with spotify" do
    visit "/"

    assert_equal 200, page.status_code

    click_link "Login with Spotify"

    user = User.last
    assert_equal landing_path(user.id), current_path
    assert page.has_content?("Edgar Duran")
    assert page.has_content?("eduran1")
    assert page.has_link?("Logout")
  end

  test "logged in user can logout" do
    login_user

    click_link "Logout"

    assert_equal "/", current_path
    assert_equal 200, page.status_code
    assert page.has_content?("Login with Spotify")
  end

  test "user sees profile and playlist link after logging in" do
    login_user

    assert page.has_content?("Edgar Duran")
    assert page.has_content?("eduran1")
    assert page.has_content?("edgarduran86@gmail.com")
    assert page.has_link?("Create and View Playlists")
    assert page.has_link?("Logout")
  end
end
