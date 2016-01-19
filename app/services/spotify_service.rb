class SpotifyService
  attr_reader :client

  def initialize(session)
    @client = RSpotify::User.new(session[:spotify_hash])
  end

  def playlists
    client.playlists
  end

  def new_playlist(name)
    client.create_playlist!(name + " PLP", public: true)
  end

  def find_playlist(params)
    RSpotify::Playlist.find(params[:user], params[:pl_id])
  end

  def songs(playlist)
    raw_data = playlist.tracks
    clean_up(raw_data)
    # client.playlist.map do |client_playlist|
    #   Playlist.new(client_playlist)
    # end
  end

  def rename_playlist(params)
    list = RSpotify::Playlist.find(params[:user], params[:pl_id])
    list.change_details!(name: params[:name] + " PLP")
  end

  # Extract to poro
  def clean_up(data)
    data.map { |song| { :name => song.name, :duration => song.duration_ms, :artists => get_artists(song.artists), :song_id => song.id} }
  end

  #Extract to poro
  def get_artists(song)
    song.map { |song| song.name }
  end

  def song_search(query)
    tracks = RSpotify::Track.search(query, limit: 20, market: "US")
    clean_up(tracks)
  end

  def find_track(id)
    RSpotify::Track.find(id)
  end

  def add_track(pl, track)
    track = [] << track
    pl.add_tracks!(track)
  end

  def remove_track(pl, track)
    track = [] << track
    pl.remove_tracks!(track)    
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
