require 'test_helper'

class LandingPageAsksVisitorToLoginTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  test "when visitor navigates to root they are asked to login" do
    visit "/"

    assert page.has_content?("Login with Spotify")
    refute page.has_content?("Create and View Playlists")
    refute page.has_link?("Logout")
  end

  test "when logged in user visits root they are redirected to profile" do
    VCR.use_cassette('redirect_landing') do
      setup

      visit "/"
      click_link "Login with Spotify"
      visit "/"

      user = User.last
      assert_equal "/landing/#{user.id}", current_path
      assert page.has_content?(user.user_name)
      assert page.has_content?(user.display_name)
    end
  end
end
