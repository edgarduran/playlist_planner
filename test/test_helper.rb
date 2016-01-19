ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'
require 'simplecov'
SimpleCov.start 'rails'

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
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
          {"token"=>
            "BQBo6kDrGvX3K7P4njwKQDAP9csxFbKyaSqMMMYVsPDnV0YAVCRhZvgfXIJ6OCwnIugodBNGuzuXbTtTfZl4RoNkBqOITbck3uZOyEsrxbWeAhY0KPc_YyJjz9DAntwPf_iI1GPf-Wmt60dkAVexJruL_6Bon5NbQwdp4PU2Xa-BJRPwymlbX4XziBVLi54PDRVDGdQz8q2xmW4NjiJsBLMMaP6c5V_h8GJpd4bl9wFTz5LtSZG1btRukXOtyvGiTgkE4IuHzZr8OQ-kecol30cUUl41Iuso0y61Nn0gdEtQCGhm",
            "refresh_token"=>"AQDgkjqHaz5KPSO1xUAwocMUvyd2k3Pkab6wLjCOZCqb1sQxTG98XYhHsrchMAcQxVSrZJl6XZLIOFjLMdQshdlnuTcerokr-4fAEW7pLNiCynMltAo611rTfZGJUaDEV3M",
            "expires_at"=>1453169555,
            "expires"=>true},
            "extra"=>{}}
      )
  end



  def login_user
    visit "/"

    assert_equal 200, page.status_code

    click_link "Sign in with Spotify"

    user = User.last
    assert_equal user_path(user.id), current_path
    assert page.has_content?("Edgar Duran")
    assert page.has_content?("eduran1")
    assert page.has_link?("Logout")
  end

end
