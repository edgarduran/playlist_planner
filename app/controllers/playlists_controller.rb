class PlaylistsController < ApplicationController

  def index
    playlists = spotify_service.playlists
    @playlists = playlists.delete_if { |playlist| !playlist.name.include?("PLP")}
  end

  def show
    @playlist = spotify_service.find_playlist(params)
    @songs    = spotify_service.songs(@playlist)
    @requests = current_user.requests.where(pl_id: params[:pl_id])
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

  def destroy
    # no method in RSpotify but maybe can use AR or just or look up
    # how gem is built. Maybe find_playlist.desroy ?
  end

  private

  def spotify_service
    SpotifyService.new(session)
  end

end
