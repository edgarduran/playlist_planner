class RequestsController < ApplicationController

  def show
    @playlist = params
  end

  def index
    @search_results = request_service.song_search(params[:query])
  end

  def create
    binding.pry
  end

  def request_service
    RequestService.new
  end

end
