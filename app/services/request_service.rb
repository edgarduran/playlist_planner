class RequestService

  def song_search(query)
    tracks = RSpotify::Track.search(query, limit: 20, market: "US")
    clean_up(tracks)
  end

  def get_artists(song)
    song.map { |song| song.name }
  end

  def clean_up(data)
    data.map { |song| { :name => song.name, :duration => song.duration_ms, :artists => get_artists(song.artists), :song_id => song.id } }
  end

end
