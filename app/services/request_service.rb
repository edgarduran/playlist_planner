class RequestService

  def self.find_playlist(params)
    binding.pry
    RSpotify::Playlist.find(params[:user], params[:pl_id])
  end

  def self.songs(playlist)
    raw_data = playlist.tracks
    clean_up(raw_data)
  end

  def self.clean_up(data)
    data.map { |song| { :name => song.name, :duration => song.duration_ms, :artists => get_artists(song.artists), :song_id => song.id} }
  end

  def self.get_artists(song)
    song.map { |song| song.name }
  end


end
