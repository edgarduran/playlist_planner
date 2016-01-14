class SpotifyService
  attr_reader :client

  def initialize(session)
    @client = RSpotify::User.new(session[:spotify_hash])
  end

  def playlists
    client.playlists
    # client.playlists.map do |client_playlist|
    #   Playlist.new(client_playlist)
    # end
  end

  def new_playlist(name)
    client.create_playlist!(name, public: true)
  end

  def find_playlist(params)
    RSpotify::Playlist.find(params[:user], params[:pl_id])
  end

  def songs(playlist)
    raw_data = playlist.tracks
    clean_up(raw_data)
  end

  def rename_playlist(params)
    list = RSpotify::Playlist.find(params[:user], params[:pl_id])
    list.change_details!(name: params[:name])
  end

  def clean_up(data)
    data.map { |song| { :name => song.name, :duration => song.duration_ms, :artists => get_artists(song.artists)} }
  end

  def get_artists(song)
    song.map { |song| song.name }
  end

end

# class Playlist
#   def initialize(client_playlist)
#   end
#
#   def tracks
#     Track.new()
#   end
# end
#
# class Track
#   def info
#     #clean up the track
#   end
# end
