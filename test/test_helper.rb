ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'
require 'webmock'
require 'vcr'
require 'simplecov'
SimpleCov.start 'rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.

  VCR.configure do |config|
    config.cassette_library_dir = "test/cassettes"
    config.hook_into :webmock
    config.allow_http_connections_when_no_cassette = true
  end
  # Add more helper methods to be used by all tests here...
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL

  def setup
    stub_omniauth
  end

  def teardown
    reset_session!
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new(
    {"provider"=>"spotify",
      "uid"=>nil,
      "info"=>
      {"birthdate"=>"1986-01-24",
        "country"=>"US",
        "display_name"=>"Edgar Duran",
        "email"=>"edgarduran86@gmail.com",
        "external_urls"=>{"spotify"=>"https://open.spotify.com/user/eduran1"},
        "followers"=>{"href"=>nil, "total"=>1},
        "href"=>"https://api.spotify.com/v1/users/eduran1",
        "id"=>"eduran1",
        "images"=>
        [{"height"=>nil,
          "url"=>"https://scontent.xx.fbcdn.net/hprofile-xpa1/v/t1.0-1/p200x200/12316497_10103623928784563_8129502248557921265_n.jpg?oh=2d87926f154e22035c51b7418cb38d52&oe=57493568",
          "width"=>nil}],
          "product"=>"premium",
          "type"=>"user",
          "uri"=>"spotify:user:eduran1"},
          "credentials"=>
          {"token" => "BQCeCiJ8nHwBCPfrDQAroc6cTmqQE0B3CeYRClbJhjB26A9mY1texZTzX-Pw5MXrS3ZSzZSY5kpVo5yUrNqjRBO2it-eGRey3xS3RZzJIGGBPwaEmRxrtFmhHD22Eo6JoSgJoX3UYybOzNqyFKjVib0EqgNdOLOCzpbjNAgu6WCekx6y2hskDqOl8ajkTx_-uKO6u-K2FEkbUjvPfYYh3iqZPYzNHovdMjtCw-UkDC5o0uMZt1qN3ra-0d13ewGOlkDV6_Cfce8XSeWfV3tZiRPsHe8G_FY5juYY0iOgEu0jgjlI",
            "refresh_token" => "AQB4aK7XoOE3QYhD2-OlQPld_3NcYE82cD5rm9CQMVyJgm_odr8n1-r7ti-gpZY_3ktbN6123Ni9KAFA1Uylv7rTQzb1A5NtuoWpsLtbLx3xvU572hoT5aGePAIS2QWUCxA",
            "expires_at"=>1453169555,
            "expires"=>true},
            "extra"=>{}}
      )
  end



  def login_user
    visit "/"

    assert_equal 200, page.status_code

    click_link "Login with Spotify"

    user = User.last
    assert_equal landing_path(user.id), current_path
    assert page.has_content?("Edgar Duran")
    assert page.has_content?("eduran1")
    assert page.has_link?("Logout")
  end

end
