class SongsController < ApplicationController
  attr_reader :pl_id, :user

  def index
    @search_results = spotify_service.song_search(params[:query])
    @pl_id = params[:pl_id]
    @pl_owner = params[:user]
  end

  def new
  end

  def create
    pl = spotify_service.find_playlist(params)
    track = spotify_service.find_track(params[:song_id])
    spotify_service.add_track(pl, track)
    redirect_to playlists_path
  end

  def add
    pl = spotify_service.find_playlist(params)
    track = spotify_service.find_track(params[:song_id])
    spotify_service.add_track(pl, track)
    redirect_to playlists_path
  end

  def destroy
    pl = spotify_service.find_playlist(params)
    track = spotify_service.find_track(params[:song_id])
    spotify_service.remove_track(pl, track)
    redirect_to playlists_path
  end

  def spotify_service
    SpotifyService.new(session)
  end

end
