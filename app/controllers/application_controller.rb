class ApplicationController < ActionController::Base

  protect_from_forgery
  helper_method :current_user, :signed_in?

  protected

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def signed_in?
    !!current_user
  end

  def login(user)
    session[:user_id] = user.id
  end

end
