class SongsController < ApplicationController
  attr_reader :pl_id, :user

  def index
    @search_results = spotify_service.song_search(params[:query])
    @pl_id = params[:pl_id]
    @pl_owner = params[:user]
  end

  def new
    # add song to playlist
    # redirect_to playlist_path(pl_id)
  end

  def create
    spotify_service.user_playlists(params)

    redirect_to playlist_path(pl_id)
  end

  def spotify_service
    SpotifyService.new(session)
  end

end
