class RequestsController < ApplicationController

  def show
    @playlist = params
  end

  def index
    @search_results = request_service.song_search(params[:query])
  end

  def create
    @request = Request.new( song_name: request_params["song_name"],
                            song_id: request_params["song_id"],
                            pl_id: request_params["pl_id"],
                            user_id: request_params["user_id"].to_i
                          )
    if @request.save
      redirect_to playlists_path
      flash[:success] = "#{@request.song_name} has been submited for approval"
    else
      flash.now[:error] = 'Something went wrong, sorry'
      redirect_to playlists_path
    end
  end

  def update
    Order.find(params[:id]).update_attributes(current_status: params[:order_status])
    redirect_to admin_dashboard_index_path
  end

  def request_service
    RequestService.new
  end

  private

  def request_params
    params.permit(:song_name, :status, :song_id, :pl_id, :user_id, :user)
  end


end
