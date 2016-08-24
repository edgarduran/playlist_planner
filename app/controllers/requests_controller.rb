class RequestsController < ApplicationController

  def show
    @playlist = params
  end

  def index
    @search_results = request_service.song_search(params[:query])

    render json: {search_results: @search_results}
  end

  def create
    @request = Request.new( song_name: request_params["song_name"],
                            song_id: request_params["song_id"],
                            pl_id: request_params["pl_id"],
                            user_id: request_params["user_id"].to_i,
                            artists: request_params["artists"]
                          )
    render json: @request
  end

  def update
    if params[:status] == "denied"
      denied = Request.find(params[:id]).update_attributes(status: params[:status])
      render json: denied
    elsif params[:status] == "approved"
      status_approved = Request.find(params[:id]).update_attributes(status: params[:status])

      render json: status_approved
    else
      redirect_to playlists_path
    end
  end

  def request_service
    RequestService.new
  end


  private

  def request_params
    params.permit(:song_name, :status, :song_id, :pl_id, :user_id, :user, :artists)
  end


end
