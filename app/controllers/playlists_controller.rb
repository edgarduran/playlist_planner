class PlaylistsController < ApplicationController

  def index
    @playlists ||= spotify_service.playlists
  end

  def show
    @playlist = spotify_service.find_playlist(params)
  end

  def new
  end

  def create
    playlist = spotify_service.new_playlist(params[:name])
    redirect_to playlists_path
  end

  def edit
    @playlist = spotify_service.find_playlist(params)
  end

  def update
    @playlist = spotify_service.rename_playlist(params)
    redirect_to playlists_path
  end

  private

  def spotify_service
    SpotifyService.new(session)
  end

end
