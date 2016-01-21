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
  fixtures :all

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
          {"token" => "BQBB-FG0AwI3b8rp8vYKq6GWnAHwMtFzeEBeg_97iq5t_BK_J_SS3Ws4Hu508QwK8EmZFVIfSgbRoxgAy9McIBOg193Vt65-ssq6mbE8h5PFdcKMN1ROE02ngP0eTecNNN_YfTjetYs316bLhH2zScQwipz2ajooQd61J-MTtbCbOOcJD1SIxF8xiQv0aX0Wv_czLCetPidq4G5-Dl1Ck60j1icCStRrqT2Mb6pO9OEDjg27fheMkNfI13L6OO1xP5Y2LQonGAeS0tjjoojKFuhoPS-naWaGty7xQdJ2mnttrXPo",
            "refresh_token" => "AQC5jBOogdGnVIKuZSycuWdQoGWEHsfVIsPYqQ5D3r2Iu-zhhmBxnYnzXDO5YsJDiJ4JgUaRqk7JXILWqtRlRrJqpX_adnTUGYYc3Kn50STPwL8LwSp2fRGPOxZv6jN-HDc",
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
