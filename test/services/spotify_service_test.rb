require './test/test_helper'
require './app/services/spotify_service'

class SpotifyServiceTest < ActiveSupport::TestCase
  attr_reader :service, :test_hash

  def create_user
    @test_hash = {
      "provider"=>"spotify",
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
            {"token" => "BQD7Aiz2qUQhDQLnRKihYZFxppQcu9LdlZwts5K_UwCX8r_w43vIQ2x9ni_YDMQadwUY8ZqKMmTIDNfFcWmSj2QcF4rn2TglqER_vlwPM5JiYaiX33HWKZORIRG3m-S8VzAH4dikx4Gqtj7LjlWDTKxOlB2qxs-Dsiy7pzaGB8TWGSPvTZF3H5UFVMnIluf7sYA0ONRq91W9DbyJUCcymoqmAk9Q0BpRA8IZmJ7lOjISzGC9g6zdr6Fjio-TGYXkk5wgBO7K1vVytbgSriYJi3TesES3_O6QL2vkjjFrqc8TvD6p",
              "refresh_token" => "AQCU4S9ePM-4igYMMundUbF6ZZBGj5eUfjmz1JeZmq7zrOuZx5vMY9qgFq3XpG_78dm9-1Zz44mS1w3dkL__poN-w_gyHkU6lxNTCl5pGkkhekk42JCklPcYGgmTbHSHFX8",
              "expires_at"=>1453169555,
              "expires"=>true},
              "extra"=>{}}
  end

  def setup
    create_user
    RSpotify::authenticate(ENV["your_client_id"], ENV["your_client_secret"])
    @service = spotify_service(test_hash)
  end

  test "#profile_image" do

    assert service.profile_image
  end

  test "#total_followers" do

    assert_equal 1, service.total_followers
  end

  test "#playlists" do
    assert service.playlists
    assert_kind_of Array, service.playlists
    refute service.playlists.count.nil?
  end


  def spotify_service(test_hash)
    SpotifyService.new(test_hash)
  end

end
