class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  helper_method :current_user
  # before_action :authorize!

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  rescue_from ActionController::InvalidAuthenticityToken do |exception|
    session.clear # Example method that will destroy the user cookies
    redirect_to "/"
  end

  # def authorize!
  #   redirect_to root_path unless current_user
  # end
end
