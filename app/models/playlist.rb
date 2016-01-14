class Playlist
  attr_reader :songs

  def initialize(songs)
    @songs = songs
    clean_up(@songs)
  end

  def clean_up(data)
    data.map { |song| { :name => song.name, :duration => song.duration_ms, :artitsts => get_artists(song.artists)} }
  end

  def get_artists(song)
    song.map { |song| song.name }
  end

end
