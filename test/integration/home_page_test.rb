require 'test_helper'

class HomePageTest < ActionDispatch::IntegrationTest
  test "user lands on homepage and see login link" do
    visit "/"
    assert page.has_content?("Login with Spotify")
  end
end
