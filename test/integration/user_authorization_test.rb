require 'test_helper'

class UserAuthorizationTest < ActionDispatch::IntegrationTest

  def setup
    Capybara.app = PlaylistPlanner::Application
    stub_omniauth
  end

  def teardown
    reset_session!
  end

  test "logged in user has access their pages" do
    VCR.use_cassette('user_login') do
      visit '/'
      click_link "Login with Spotify"
      assert_equal 200, page.status_code
      assert page.has_content?("Edgar Duran")
      assert page.has_content?("eduran1")
      assert page.has_link?("Logout")
    end
  end
end
