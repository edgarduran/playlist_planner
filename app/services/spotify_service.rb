class SpotifyService
  attr_reader :client

  def initialize(session)
    @client = RSpotify::User.new(session[:spotify_hash])
  end

  def playlists
    client.playlists
  end

  def new_playlist(name)
    client.create_playlist!(name, public: true)
  end

  def find_playlist(params)
    RSpotify::Playlist.find(params[:user], params[:pl_id])
  end

  def rename_playlist(params)
    list = RSpotify::Playlist.find(params[:user], params[:pl_id])
    list.change_details!(name: params[:name])
  end

end
