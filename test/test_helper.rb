ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'mocha/mini_test'

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
    OmniAuth.config.mock_auth[:spotify] = nil
  end

  def stub_omniauth
    OmniAuth.config.test_mode = true

    OmniAuth.config.mock_auth[:spotify] = OmniAuth::AuthHash.new({
      provider: 'spotify',
      info: {
        display_name: "Edgar Duran",
        email: "edgarduran86@gmail.com",
        id: "eduran1",
        images:      [{"height"=>nil,
                       "url"=>"https://scontent.xx.fbcdn.net/hprofile-xpa1/v/t1.0-1/p200x200/12316497_10103623928784563_8129502248557921265_n.jpg?oh=2d87926f154e22035c51b7418cb38d52&oe=57493568",
                       "width"=>nil}],
                     },
        credentials: {
          token:  "BQDNFf7RRRhDghcLNpfQcobPjqfMpP_YM-C1S5NExZNPhEz1HvaxkdLIaV8gI7XjTjuiXmsYpthxnZKRYBYgWsf8GkT0MeutrhqvwbjVbk20dH-7KG450q40g6t2kaVsG2ARAAFXtoTplMgi4-6fqRMycNZT7rD3aVnd3StWWC8jjZica10PPj-fOBL--dCFVkKp-lUmBVIw27yjRSDl73oNdegP-lq2H15dARxePAn4QcQ3eF9_KTOLUqEqtul05IZ4-7p6EH-R-hh7y8fykiZvo5Y_mj6Kg0FU65JaQsp3rPfB",
          refresh_token:  "AQC3mwMkMC-sQeUfmYoN4rYi7AJdgjx2XNTh2nLqG6dYR77rIMC3CcOUmsmIfwUDv-h0LacfamO_yf-7hU5HKNCGyuyi-JVZIqcj3E0tNnIZipT7QS287lII6Bq7096aE3g"
      }
      })
    end

  end
