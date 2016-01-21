class LandingController < ApplicationController

  def index
    if current_user
      redirect_to landing_path(current_user)
    end
  end

  def show
  end
end
