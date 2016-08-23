class SongsController < ApplicationController
  attr_reader :pl_id, :user

  def index
    @search_results = spotify_service.song_search(params[:query])
    @pl_id = params[:pl_id]
    @pl_owner = params[:user]
    #
    # render json: @product

    render json: {search_results: @search_results}
  end


  def create
    pl = spotify_service.find_playlist(params)
    track = spotify_service.find_track(params[:song_id])

    render json: spotify_service.add_track(pl, track)
  end

  def add
    pl = spotify_service.find_playlist(params)
    track = spotify_service.find_track(params[:song_id])
    added = spotify_service.add_track(pl, track)

    render json: added
  end

  def destroy
    pl = spotify_service.find_playlist(params)
    track = spotify_service.find_track(params[:song_id])
    removed = spotify_service.remove_track(pl, track)

    render json: removed
  end

  def spotify_service
    SpotifyService.new(session)
  end

end
