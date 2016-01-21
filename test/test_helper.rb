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
          {"token" => "BQDTlQkQZmfa_SDh0fqFo5N4n7FrPysLL0cIgzuMhZs7jMllQyBRctMh5mxh8R2KN8Dv_XOIejPIqE4ITdNYwRbGnZ_pnFL-wuMUc6hC1RCYj5cvDB_1Qo_mz52ipltBM1fhj2fu9H4eYD5wD4ePGp6sci5oUlSlQSipoIZQLaYLNIT1QY_PZxg1YZvr_GXbGpUQ47c3R5TKUVgHoqMP_MtEyXX2kp8OPfUcLVT9kfWHcQoQCCsAm_cntrYOZMWP8FhnodTGpHJXNKfSr0q-M9uAg1eaWJJdWECdKzfxg75lnmjh",
            "refresh_token" => "AQCPB_zQVA2HbJG3VtLWBk8mwVB5yTYCaPa_1Zl2Lv7bEn3EO7F8DSU1kULZlDNLr6o6dkk_ftHkg4aEjPavbHQHVn8OJdxFm3T8K0anW5EyyyHHFQIfLgmVIxfjXst1B5A",
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
