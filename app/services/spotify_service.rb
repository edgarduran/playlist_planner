class SpotifyService
  attr_reader :client

  def initialize(session)
    @client = RSpotify::User.new(session[:spotify_hash])
  end

  def playlists
    client.playlists
  end

end
