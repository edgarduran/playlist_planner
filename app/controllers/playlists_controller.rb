class PlaylistsController < ApplicationController

  def index
    user ||= spotify_service
    @playlists = user.playlists
  end

  def new
  end

  def create
  end

  private

  def spotify_service
    SpotifyService.new(session)
  end

end
