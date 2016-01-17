class SessionsController < ApplicationController

  def create
    user = User.find_or_create_from_oauth(oauth)
    if user
      session[:user_id] = user.id
      session[:spotify_hash] = oauth
      redirect_to landing_path(user)

    else
      redirect_to "/"
    end
  end

  def destroy
    session.clear
    redirect_to "/"
  end

  private
  def oauth
    request.env['omniauth.auth']
  end

end
